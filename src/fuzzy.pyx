cdef extern from "string.h":
	int strlen(char *s)

cdef extern from "ctype.h":
	int toupper(int c)

cdef extern from "stdlib.h":
	void * malloc(int i)
	void free(void * buf)

cdef class Soundex:
	cdef int size
	cdef char *map

	def __init__(self, size):
		self.size = size
		self.map = "01230120022455012623010202"
		
	def __call__(self, s):
		cdef char *cs
		cdef int ls
		cdef int i
		cdef int written 
		cdef char *out

		written = 0

		out = <char *>malloc(self.size + 1)
		cs = s
		ls = strlen(cs)
		for i from 0<= i < ls:
			if cs[i] >= 97 and cs[i] <= 122:
				cs[i] = cs[i] - 32
			if cs[i] >= 65 and cs[i] <= 90:
				if written == 0:
					out[written] = cs[i]
					written = written + 1
				elif self.map[cs[i] - 65] != 48 and (written == 1 or 
							out[written - 1] != self.map[cs[i] - 65]):
					out[written] = self.map[cs[i] - 65]
					written = written + 1
			if written == self.size:
				break
		for i from written <= i < self.size:			
			out[i] = 48
		out[self.size] = 0

		pout = out
		free(out)

		return pout

cdef extern from "double_metaphone.h":
	void DoubleMetaphone(char *str, char **codes)

cdef class DMetaphone:
	cdef int size

	def __init__(self, size=0):
		self.size = size or 99999
		
	def __call__(self, s):
		cdef char *cs
		cdef char **out
		out = <char **>malloc(sizeof(char *) * 2)
		cs = s
		DoubleMetaphone(cs, out)
		o1 = out[0]
		o2 = out[1]
		if out[0] != NULL:
			free(out[0])
		if out[1] != NULL:
			free(out[1])

		free(out)

		if o1 == o2:
			o2 = None

		return [o1 and o1[:self.size] or None, o2 and o2[:self.size] or None]
