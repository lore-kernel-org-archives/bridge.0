Date: Tue, 13 Jul 2004 13:43:34 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge support unavailable
Message-Id: <20040713134334.03c62ab8@dell_ss3.pdx.osdl.net>
In-Reply-To: <1089749757.31365@baywinds.org>
References: <1089749757.31365@baywinds.org>
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
To: bferrell@baywinds.org
Cc: Bert Hubbs <bhubbs@mbgdocs.com>, bridge@lists.osdl.org

On Tue, 13 Jul 2004 13:15:57 -0700
bferrell@baywinds.org wrote:

> Stephen,
> 
> The module will only autoload if /etc/modules.conf is setup for it.  Checking  redhat 7.3, redhat 9.0, WhiteBox EL3, Suse 8.0 and Suse 9.0 systems, none have anything to cause bridge.o to alias to br0.  Those are the only systems I have to look at.  I don't know what other distros like debian or mandrake do for bridge.o.  They might have it in the modules.conf file... Dunno.
> 

Wrong!  It gets done by:
	static int sock_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
		      unsigned long arg)
{
	...
	switch(cmd) {
	...
		case SIOCGIFBR:
		case SIOCSIFBR:
		case SIOCBRADDBR:
		case SIOCBRDELBR:
			err = -ENOPKG;
			if (!br_ioctl_hook)
				request_module("bridge");


> So, Bert, you'll need to add something like this to /etc/modules.conf:
> 
> alias br0 bridge

Don't do that.  It will autoload the bridge, but br0 will not be created automatically!
I.e. if the configuration script does:
	ifconfig br0 up

Then it will load the bridge module, but since the bridge hasn't been created you will
get "no such device" error.
