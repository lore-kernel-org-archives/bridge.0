Subject: RE: [Bridge] SUSE 8.1 build failure
From: Torsten Luettgert <t.luettgert@pressestimmen.de>
In-Reply-To: <000f01c483f2$20f35a00$ba00a8c0@hasslemonkey.net>
References: <000f01c483f2$20f35a00$ba00a8c0@hasslemonkey.net>
Content-Type: text/plain
Message-Id: <1092728709.2909.4.camel@scaramouche>
Mime-Version: 1.0
Date: Tue, 17 Aug 2004 09:45:11 +0200
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Gareth Wheelton <gareth@hasslemonkey.net>
Cc: bridge@lists.osdl.org

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

