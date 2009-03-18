MIME-Version: 1.0
Date: Wed, 18 Mar 2009 06:12:19 +0000
Message-ID: <fed120860903172312u1635ac3dj94be3a5c4811ff0a@mail.gmail.com>
From: "Srinivas M.A." <srinivas.aji@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge]  RSTP timeout calculations
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Bernhard Weirich <bernhard.weirich@riedel.net>

Hi,

Bernhard Weirich pointed out that using gettimeofday(2) for timeout
calculations can cause problems when system date/time is changed.

Here is a patch to use times(2) instead of gettimeofday(2) to avoid
being affected by changes in system date/time. times(2) returns the
tick count of a clock which is running constantly since system boot.
But the times(2) man page seems to recommend against using it for
elapsed time and recommends gettimeofday(2) instead. Any comments
about that?

Thanks,
Srinivas

---------------- begin patch ------------------------

--- a/epoll_loop.c
+++ b/epoll_loop.c
@@ -26,7 +26,7 @@

 #include <sys/epoll.h>
 #include <errno.h>
-#include <sys/time.h>
+#include <sys/times.h>
 #include <time.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -35,7 +35,8 @@

 // globals
 int epoll_fd = -1;
-struct timeval nexttimeout;
+clock_t nexttimeout;
+clock_t clks_per_sec;

 int init_epoll(void)
 {
@@ -45,6 +46,9 @@ int init_epoll(void)
                return -1;
        }
        epoll_fd = r;
+
+       clks_per_sec = (clock_t)sysconf(_SC_CLK_TCK);
+
        return 0;
 }

@@ -83,22 +87,15 @@ void clear_epoll(void)
                close(epoll_fd);
 }

-int time_diff(struct timeval *second, struct timeval *first)
-{
-       return (second->tv_sec - first->tv_sec) * 1000
-           + (second->tv_usec - first->tv_usec) / 1000;
-}
-
 void run_timeouts(void)
 {
        bridge_one_second();
-       nexttimeout.tv_sec++;
+       nexttimeout += clks_per_sec;
 }

 int epoll_main_loop(void)
 {
-       gettimeofday(&nexttimeout, NULL);
-       nexttimeout.tv_sec++;
+       nexttimeout = times(NULL) + clks_per_sec;
 #define EV_SIZE 8
        struct epoll_event ev[EV_SIZE];

@@ -106,12 +103,13 @@ int epoll_main_loop(void)
                int r, i;
                int timeout;

-               struct timeval tv;
-               gettimeofday(&tv, NULL);
-               timeout = time_diff(&nexttimeout, &tv);
-               if (timeout < 0) {
+               clock_t now = times(NULL);
+               long clocks_left = (long)(nexttimeout - now);
+               if (clocks_left <= 0) {
                        run_timeouts();
                        timeout = 0;
+               } else {
+                       timeout = (clocks_left * 1000) / clks_per_sec;
                }

                r = epoll_wait(epoll_fd, ev, EV_SIZE, timeout);

--------------------- end patch ------------------------


On Mon, Feb 9, 2009 at 1:55 PM, Bernhard Weirich
<bernhard.weirich@riedel.net> wrote:
> On Sun, 2009-02-08 at 07:15 +0100, Srinivas M.A. wrote:
>
>>diff -Naur rstp/brmon.c rstp-2/brmon.c
>>--- rstp/brmon.c        2008-07-02 07:06:25.000000000 +0200
>>+++ rstp-2/brmon.c      2009-02-06 15:08:21.000000000 +0100
>>@@ -109,7 +109,7 @@
>>
>>
>>        if (tb[IFLA_OPERSTATE]) {
>>-               int state = *(int*)RTA_DATA(tb[IFLA_OPERSTATE]);
>>+               int state = *(uint8_t*)RTA_DATA(tb[IFLA_OPERSTATE]);
>>                switch (state) {
>>                case IF_OPER_UNKNOWN:
>>                        fprintf(fp, "Unknown "); break;
>
> Okay. The fix "Netlink data element size fixes" by Solomon Peachy
> fixed some other places where this was happening, but missed this
> logging part.
>
> Well I found the size problems as well but he was faster with the patch.
>
>
>
>>diff -Naur rstp/epoll_loop.c rstp-2/epoll_loop.c
>>--- rstp/epoll_loop.c   2008-02-27 19:05:49.000000000 +0100
>>+++ rstp-2/epoll_loop.c 2009-02-06 14:22:30.000000000 +0100
>>@@ -32,6 +32,8 @@
>> #include <unistd.h>
>>
>> #include "bridge_ctl.h"
>>+#include "log.h"
>>+
>>
>> // globals
>> int epoll_fd = -1;
>>@@ -109,7 +111,13 @@
>>                struct timeval tv;
>>                gettimeofday(&tv, NULL);
>>                timeout = time_diff(&nexttimeout, &tv);
>>-               if (timeout < 0) {
>>+               if (timeout > 1000 * 2 || timeout < -1000 * 60) {
>>+                       gettimeofday(&nexttimeout, NULL);
>>+                       nexttimeout.tv_sec++;
>>+                       INFO("Time leap detected. Refusing to wait: %d
>> sec\n", timeout / 1000);
>>+                       continue;
>>+               }
>>+               if (timeout < 0) {
>>                        run_timeouts();
>>                        timeout = 0;
>>                }
>
> It looks like this is to account for the case where the system time is
> externally changed. Is that the case?
>
> Precisely.
>
> Maybe I should be using the return value of times(2) instead of
> gettimeofday, since times() is returning clock ticks from boot time
> with an arbitrary initial offset.
>
> This is much better than my solution.
