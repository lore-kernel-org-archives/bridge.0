Date: Mon, 3 Jan 2005 10:42:37 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge Utils & 2.6.7 Kernel
Message-Id: <20050103104237.76a0445f@dxpl.pdx.osdl.net>
In-Reply-To: <1104271176.17168.11.camel@honeycomb>
References: <1104271176.17168.11.camel@honeycomb>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: raj@roinet.com
Cc: bridge@lists.osdl.org

On Tue, 28 Dec 2004 16:59:37 -0500
Rajashekhar Mansanpally <raj@roinet.com> wrote:

> Hi everyone,
> I am trying to get bridging working with 2.6.7 kernel.
> I have noticed quite a few additions to the bridge code, last one I used
> was with 2.4.x series, most importantly Sysfs.

sysfs support for bridge may not have been available to 2.6.8
Look for net/bridge/br_sysfs_br.c in source.

> Can someone tell me what I need to do to enable sysfs support ?

Sysfs is enabled in the kernel (unless you configure it for embedded and turn off sysfs).
There needs to be an entry in mount table /etc/mtab to mount it. All 2.6 based
distro's mount it in /sys.  The bridge-utils configure tries to figure out
if you have libsysfs to access it.  Early 2.6 distro's did not have a package
for it, so you may have to download it and build it.

> I did not find the bridge module in /sys directory structure even after
> adding couple of interfaces to the bridge. Is there anything
> else I need to do?

The bridge shows up as /sys/class/net/br0/bridge and /sys/class/net/eth0/brif/

> Thanks in advance.
> 
> -Raj
> 
> 
