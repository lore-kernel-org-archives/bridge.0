Date: Thu, 8 Jul 2004 10:23:59 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Request Help: Error when compiling with Bridging enabled
Message-Id: <20040708102359.58b67ae8@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040708162733.86A92600FE@cmlapp13.siteprotect.com>
References: <20040708162733.86A92600FE@cmlapp13.siteprotect.com>
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
To: sam.stephenson@ezadcorp.com
Cc: bridge@lists.osdl.org

On Thu, 8 Jul 2004 11:29:28 -0500
"Sam Stephenson" <sam.stephenson@ezadcorp.com> wrote:

> I am attempting to use the bridging-utilities (i.e., bridge-utils-0.9.5.1)
> in an
> 
> Linux-arm environment (linux-arm 2.4.19).
> 
>  
> 
> But, when executed command listed below, further investigation indicated we
> are required to
> 
> rebuild kernel to enable the bridging code.
> 
>  
> 
> # brctl addbr br0
> 
> br_add_bridge: Package not installed
> 
>  
> 
> Therefore our initial attempt to rebuild kernel failed as indicated below
> (with
> 
> "CONFIG_BRIDGE=y" ) in .config file. 
> 
>  
> 
> net/network.o: In function `__br_clear_frame_hook':
> 
> net/network.o(.text+0x461dc): undefined reference to `br_handle_frame_hook'
> 
> net/network.o: In function `__br_clear_ioctl_hook':
> 
> net/network.o(.text+0x461fc): undefined reference to `br_ioctl_hook'
> 
> net/network.o: In function `br_init':
> 
> net/network.o(.text.init+0x2c50): undefined reference to
> `br_handle_frame_hook'
> 
> net/network.o(.text.init+0x2c5c): undefined reference to `br_ioctl_hook'
> 
> make: *** [vmlinux] Error 1
> 

You need to probably do a "make mrproper" then make again to force
a complete kernel rebuild.

