#!/usr/bin/env dtrace -Cs

#pragma D option quiet

#define MILLISEC (1000)
#define	MICROSEC (1000 * 1000)
#define	NANOSEC  (1000 * 1000 * 1000)

dtrace:::BEGIN
{
  printf("NODE DNS-LOOKUPS\n\n");
  printf("______________________________________________________________________________\n");
  printf("| %6s | %-20s | %-20s | %-6s | %10s |\n", "PID", "URL", "ADDRESS", "FAMILY", "LATENCY");
  printf("|--------|----------------------|----------------------|--------|------------|\n");
  start = timestamp;
}

nodedns*:::lookup-start
{
  lstarts[pid, copyinstr(arg0), arg1] = timestamp;
  self->ts = timestamp;
}

nodedns*:::lookup-end
/self->ts/
{
  printf("| %6d | %-20s | %-20s | %-6d | %4d.%-03dms |\n",
         pid,
         copyinstr(arg0),
         copyinstr(arg1),
         arg2,
         (timestamp-self->ts)/MICROSEC,
         ((timestamp-self->ts)%MICROSEC)/1000);

  lstarts[pid, copyinstr(arg0), arg2] = 0;
}

dtrace:::END
{
  printf("______________________________________________________________________________\n");
  printf("done...\n");
}
