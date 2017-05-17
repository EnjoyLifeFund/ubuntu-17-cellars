/* Default linker script, for normal executables */
/* Copyright (C) 2014-2017 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("coff-h8300")
OUTPUT_ARCH(h8300sn)
ENTRY (_start)
MEMORY
{
	/* 0xc4 is a magic entry.  We should have the linker just
	   skip over it one day...  */
	vectors : o = 0x0000, l = 0xc4
	magicvectors : o = 0xc4, l = 0x3c
	ram    : o = 0x0100, l = 0xfdfc
	/* The stack starts at the top of main ram.  */
	topram : o = 0xfefc, l = 0x4
	/* At the very top of the address space is the 8-bit area.  */
	eight : o = 0xff00, l = 0x100
}
SECTIONS
{
.vectors :
	{
	  /* Use something like this to place a specific
	     function's address into the vector table.
	     SHORT (ABSOLUTE (_foobar)).  */
	  *(.vectors)
	}  > vectors
.text :
	{
	  *(.rodata)
	  *(.text)
	  *(.strings)
   	   _etext = . ;
	}  > ram
.tors :
	{
	  ___ctors = . ;
	  *(.ctors)
	  ___ctors_end = . ;
	  ___dtors = . ;
	  *(.dtors)
	  ___dtors_end = . ;
	} > ram
.data :
	{
	  *(.data)
	  *(.tiny)
	   _edata = . ;
	}  > ram
.bss :
	{
	   _bss_start = . ;
	  *(.bss)
	  *(COMMON)
	   _end = . ;
	}  >ram
.stack :
	{
	   _stack = . ;
	  *(.stack)
	}  > topram
.eight :
	{
	  *(.eight)
	}  > eight
.stab 0 (NOLOAD) :
	{
	  [ .stab ]
	}
.stabstr 0 (NOLOAD) :
	{
	  [ .stabstr ]
	}
}
