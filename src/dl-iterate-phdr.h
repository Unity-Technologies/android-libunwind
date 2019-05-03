#ifndef dl_iterate_phdr_h
#define dl_iterate_phdr_h

#if defined(__arm__) && (__ANDROID_API__ < 21)
int
dl_iterate_phdr (int (*callback) (struct dl_phdr_info *info, size_t size, void *data),
                 void *data);
#endif /* defined(__arm__) && (__ANDROID_API__ < 21) */

#endif /* dl_iterate_phdr_h */
