Message-ID: <dbf855d00512301013g5eafdf8du9556be854480324d@mail.gmail.com>
Date: Fri, 30 Dec 2005 10:13:25 -0800
From: <wandering.womble@gmail.com>
Subject: Re: [Bridge] eth0- can't enslave to br0,
	but eth0 is down and not part of a bridge!
In-Reply-To: <20051230094730.14498125@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
References: <dbf855d00512300011t6c4c445w2109458b1c036083@mail.gmail.com>
	<20051230094730.14498125@localhost.localdomain>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Ooops- sorry, kernel versions tried are 2.6.14 & 2.6.14-ck6- both with
the same results.
Both are clean installs (i.e. just got the code and compiled), both
using the same original .config (make oldconfig, then make menuconfig,
make .... etc)

Bridging is enabled as a module; the sis 900 (eth0) and tap drivers
are also modules.

I didn't notice any errors or other problems with the kernel compiles.

From what you're saying, there's some special code #ifdef'd in
ethernet drivers if bridging is enabled- perhaps the sis900 driver has
some bugs with regard to handling this?  Any hints on what I should be
looking for?

Thanks in advance,

Julian

> Need to know. Kernel version, and what kind of device eth0 is.
> I suspect there is a build problem or module mismatch, since the test
> for a device being member of a bridge is just a check for pointer in
> device structure.  If you built bridge separately, and kernel was not configured
> to enable bridging, then the bridge pointer in the net device structure would not
> have existed and would be used for something elese.
>

