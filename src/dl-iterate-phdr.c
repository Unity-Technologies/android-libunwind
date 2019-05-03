/* libunwind - a platform-independent unwind library
   Copyright (C) 2003-2005 Hewlett-Packard Co
	Contributed by David Mosberger-Tang <davidm@hpl.hp.com>

This file is part of libunwind.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */

#include "libunwind_i.h"
#include "dl-iterate-phdr.h"

#if defined(__arm__) && (__ANDROID_API__ < 21)

#ifndef IS_ELF
/* Copied from NDK header. */
#define IS_ELF(ehdr) ((ehdr).e_ident[EI_MAG0] == ELFMAG0 && \
                      (ehdr).e_ident[EI_MAG1] == ELFMAG1 && \
                      (ehdr).e_ident[EI_MAG2] == ELFMAG2 && \
                      (ehdr).e_ident[EI_MAG3] == ELFMAG3)
#endif

int
dl_iterate_phdr (int (*callback) (struct dl_phdr_info *info, size_t size, void *data),
                 void *data) {
  unw_map_cursor_t cursor;
  unw_map_t map;
  Elf_W(Ehdr) *ehdr;
  Elf_W(Phdr) *phdr;
  struct dl_phdr_info info;
  int rc = 0;

  unw_map_local_create ();
  unw_map_local_cursor_get (&cursor);

  while (unw_map_local_cursor_get_next (&cursor, &map) > 0)
  {
    ehdr = (Elf_W(Ehdr) *) map.start;
    if (map.path[0] && ((map.flags & (PROT_EXEC | PROT_READ)) == (PROT_EXEC | PROT_READ)) && IS_ELF(*ehdr)) {
      phdr = (Elf_W(Phdr) *) ((char *) ehdr + ehdr->e_phoff);
      info.dlpi_addr = map.start;
      info.dlpi_name = map.path;
      info.dlpi_phdr = phdr;
      info.dlpi_phnum = ehdr->e_phnum;
      rc = callback(&info, sizeof(info), data);
    }

    free(map.path);
    if (rc)
      break;
  }

  unw_map_local_destroy ();
  return rc;
}

#endif /* defined(__arm__) && (__ANDROID_API__ < 21) */
