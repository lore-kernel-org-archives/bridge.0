Date: Fri, 13 May 2005 16:33:47 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Can it possible to call the bridge ioctl calls from
	another module code...
Message-ID: <20050513163347.39097bb5@dxpl.pdx.osdl.net>
In-Reply-To: <ace3f33d05050917531641fb@mail.gmail.com>
References: <ace3f33d05050917531641fb@mail.gmail.com>
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
To: srinivas naga vutukuri <srinivas.vutukuri@gmail.com>
Cc: bridge@lists.osdl.org

On Tue, 10 May 2005 06:23:24 +0530
srinivas naga vutukuri <srinivas.vutukuri@gmail.com> wrote:

> Hi,
> 
>           I am using 2.4.x kernel and the kernel native bridge code
> (for bridging).
> I am creating Pseudo net_devices'  which should be added to the bridge
> interfaces.
> without intervention of bridge-utils (ie., brctl) to add interface
> from the userland,
> can i able to call the br_ioctl (), br_ioctl_deviceless_stub () which
> is calling the static br_ioctl_deviceless () function, which is
> adding/deleting the interface from the
> bridge. But my doubt is they are not defined as static, am thought global scope,
> but no where exported those function symbols, so using directly into
> another module is correct way of usage?
> 

What you need to do is have a socket around and feed sock_ioctl()
the appropriate request.  Alternatively, you could simulate user call like
the code in 2.6 br_if.c does to fake ethtool:
	strncpy(ifr.ifr_name, dev->name, IFNAMSIZ);
	ifr.ifr_data = (void __user *) &ecmd;

	old_fs = get_fs();
	set_fs(KERNEL_DS);
	err = dev_ethtool(&ifr);
	set_fs(old_fs);
	
	if (!err) {

Easier to just do something call_usermodehelper or do it all from user mode.

