From: "Gareth Wheelton" <gareth@hasslemonkey.net>
Subject: RE: [Bridge] SUSE 8.1 build failure
Date: Wed, 18 Aug 2004 17:26:20 +0100
Message-ID: <000b01c48540$189cb1e0$ba00a8c0@hasslemonkey.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <1092728709.2909.4.camel@scaramouche>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I think 'libbride_private.h' was missing '#include <linux/hz.h>'

OK that's sorts out the compile, leaving the following link error:

gcc  brctl.o brctl_cmd.o brctl_disp.o  -L ../libbridge -lbridge  -o brctl
../libbridge/libbridge.a(libbridge_devif.o): In function `get_hz':
/usr/src/linux/include/linux/hz.h:19: undefined reference to `__HZ'
collect2: ld returned 1 exit status
make: *** [brctl] Error 1


Using 'nm' I found many modules under '/lib/modules/2.4.21-241-athlon'
referencing an undefined symbol '__HZ_R799069f6'. Maybe this is related?

My kernel is configured correctly i.e. CONFIG_BRIDGE=m


So where does '__HZ' live?


Cheers again.


gareth



-----Original Message-----
From: Torsten Luettgert [mailto:t.luettgert@pressestimmen.de] 
Sent: 17 August 2004 08:45
To: Gareth Wheelton
Cc: bridge@lists.osdl.org
Subject: RE: [Bridge] SUSE 8.1 build failure

On Die, 2004-08-17 at 02:35, Gareth Wheelton wrote:
> Does anyone know where 'HZ' is declared in the 2.4.xx source?

grep is your friend:

# fgrep -r '#define HZ' /usr/src/linux
[...]
/usr/src/linux/include/asm-i386/param.h:#define HZ 100
[...]

so, you should insert

#include <asm/param.h>

into the module that doesn't compile.

- Torsten



