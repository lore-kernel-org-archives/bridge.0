Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05AE74103C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2277140C31
MIME-Version: 1.0
Date: Fri, 30 Sep 2022 17:33:26 +0200
From: netdev@kapio-technology.com
In-Reply-To: <Yzb3oNGNtq4GCS3M@shredder>
References: <20220928150256.115248-1-netdev@kapio-technology.com>
 <20220929091036.3812327f@kernel.org>
 <12587604af1ed79be4d3a1607987483a@kapio-technology.com>
 <20220929112744.27cc969b@kernel.org>
 <ab488e3d1b9d456ae96cfd84b724d939@kapio-technology.com>
 <Yzb3oNGNtq4GCS3M@shredder>
Message-ID: <ee5317df52609e0d7c0fdbccf0421a69@kapio-technology.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH v6 net-next 0/9] Extend locked port feature
 with FDB locked flag (MAC-Auth/MAB)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On 2022-09-30 16:05, Ido Schimmel wrote:
> What exactly is the issue? You should be able to run the tests with 
> veth
> pairs in a VM.

First there is an issue with alsa missing for some mixer tests, then 
there is several reports of sys/capability.h missing, and then just 
really many obscure problems that look like wrong lib versions are in 
place. Here is some of the long log of errors etc... :(


In file included from lib/elf.c:8:
include/test_util.h: In function ‘align_up’:
include/test_util.h:134:7: warning: format ‘%lu’ expects argument of 
type ‘long unsigned int’, but argument 6 has type ‘uint64_t’ {aka ‘long 
long unsigned int’} [-Wformat=]
   134 |       "size not a power of 2: %lu", size);
       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~  ~~~~
       |                                     |
       |                                     uint64_t {aka long long 
unsigned int}
include/test_util.h:54:43: note: in definition of macro ‘TEST_ASSERT’
    54 |  test_assert((e), #e, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
       |                                           ^~~
include/test_util.h:134:33: note: format string is defined here
   134 |       "size not a power of 2: %lu", size);
       |                               ~~^
       |                                 |
       |                                 long unsigned int
       |                               %llu
include/test_util.h: In function ‘align_ptr_up’:
include/test_util.h:150:9: warning: cast to pointer from integer of 
different size [-Wint-to-pointer-cast]
   150 |  return (void *)align_up((unsigned long)x, size);
       |         ^
In file included from include/kvm_util.h:10,
                  from lib/elf.c:13:
include/kvm_util_base.h: At top level:
include/kvm_util_base.h:93:26: error: field ‘stats_header’ has 
incomplete type
    93 |  struct kvm_stats_header stats_header;
       |                          ^~~~~~~~~~~~
In file included from ../../../include/linux/kernel.h:8,
                  from ../../../include/linux/list.h:7,
                  from ../../../include/linux/hashtable.h:10,
                  from include/kvm_util_base.h:13,
                  from include/kvm_util.h:10,
                  from lib/elf.c:13:
include/kvm_util_base.h: In function ‘kvm_vm_reset_dirty_ring’:
include/kvm_util_base.h:308:24: error: ‘KVM_RESET_DIRTY_RINGS’ 
undeclared (first use in this function); did you mean 
‘KVM_GET_DIRTY_LOG’?
   308 |  return __vm_ioctl(vm, KVM_RESET_DIRTY_RINGS, NULL);
       |                        ^~~~~~~~~~~~~~~~~~~~~
../../../include/linux/build_bug.h:79:56: note: in definition of macro 
‘__static_assert’
    79 | #define __static_assert(expr, msg, ...) _Static_assert(expr, 
msg)
       |                                                        ^~~~
include/kvm_util_base.h:193:2: note: in expansion of macro 
‘static_assert’
   193 |  static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) == 
_IOC_SIZE(cmd), ""); \
       |  ^~~~~~~~~~~~~
include/kvm_util_base.h:216:2: note: in expansion of macro 
‘kvm_do_ioctl’
   216 |  kvm_do_ioctl((vm)->fd, cmd, arg);   \
       |  ^~~~~~~~~~~~
include/kvm_util_base.h:308:9: note: in expansion of macro ‘__vm_ioctl’
   308 |  return __vm_ioctl(vm, KVM_RESET_DIRTY_RINGS, NULL);
       |         ^~~~~~~~~~
include/kvm_util_base.h:308:24: note: each undeclared identifier is 
reported only once for each function it appears in
   308 |  return __vm_ioctl(vm, KVM_RESET_DIRTY_RINGS, NULL);
       |                        ^~~~~~~~~~~~~~~~~~~~~
../../../include/linux/build_bug.h:79:56: note: in definition of macro 
‘__static_assert’
    79 | #define __static_assert(expr, msg, ...) _Static_assert(expr, 
msg)
       |                                                        ^~~~
include/kvm_util_base.h:193:2: note: in expansion of macro 
‘static_assert’
   193 |  static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) == 
_IOC_SIZE(cmd), ""); \
       |  ^~~~~~~~~~~~~
include/kvm_util_base.h:216:2: note: in expansion of macro 
‘kvm_do_ioctl’
   216 |  kvm_do_ioctl((vm)->fd, cmd, arg);   \
       |  ^~~~~~~~~~~~
include/kvm_util_base.h:308:9: note: in expansion of macro ‘__vm_ioctl’
   308 |  return __vm_ioctl(vm, KVM_RESET_DIRTY_RINGS, NULL);
       |         ^~~~~~~~~~
include/kvm_util_base.h:193:16: error: expression in static assertion is 
not an integer
   193 |  static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) == 
_IOC_SIZE(cmd), ""); \
       |                ^
../../../include/linux/build_bug.h:79:56: note: in definition of macro 
‘__static_assert’
    79 | #define __static_assert(expr, msg, ...) _Static_assert(expr, 
msg)
       |                                                        ^~~~
include/kvm_util_base.h:193:2: note: in expansion of macro 
‘static_assert’
   193 |  static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) == 
_IOC_SIZE(cmd), ""); \
       |  ^~~~~~~~~~~~~
include/kvm_util_base.h:216:2: note: in expansion of macro 
‘kvm_do_ioctl’
   216 |  kvm_do_ioctl((vm)->fd, cmd, arg);   \
       |  ^~~~~~~~~~~~
include/kvm_util_base.h:308:9: note: in expansion of macro ‘__vm_ioctl’
   308 |  return __vm_ioctl(vm, KVM_RESET_DIRTY_RINGS, NULL);
       |         ^~~~~~~~~~
include/kvm_util_base.h: In function ‘vm_get_stats_fd’:
include/kvm_util_base.h:313:26: error: ‘KVM_GET_STATS_FD’ undeclared 
(first use in this function); did you mean ‘KVM_GET_SREGS’?
   313 |  int fd = __vm_ioctl(vm, KVM_GET_STATS_FD, NULL);
       |                          ^~~~~~~~~~~~~~~~
