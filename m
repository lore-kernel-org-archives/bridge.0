Date: Wed, 25 Feb 2004 08:27:10 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] (no subject)
Message-Id: <20040225082710.2a593f2d@dell_ss3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.44.0402250913190.28057-200000@dane-linux.aiinet.priv>
References: <Pine.LNX.4.44.0402250913190.28057-200000@dane-linux.aiinet.priv>
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
To: dane@aiinet.com
Cc: john.wise@harris.com, bridge@osdl.org

On Wed, 25 Feb 2004 09:30:07 -0500 (EST)
Dan Eble <dane@aiinet.com> wrote:

> Attached is the BCP patch for pppd 2.4.1.  In addition to BCP, there are
> also a few changes to support a pppd plugin for devices using the kernel
> generic HDLC layer.  The plugin itself is not included in this patch.
> 
> There were some changes to log messages that I tried to remove by hand.  
> The patch applies cleanly and compiles on 686.  It has never been tested
> on 686, though, only on powerpc.  I would appreciate hearing about any
> difficulties you encounter.
> 
> You must patch the kernel too.  I will send those changes in a separate
> mail.
> 
> -- 
> Dan Eble <dane@aiinet.com>  _____  .
> Software Engineer          |  _  |/|
> Applied Innovation Inc.    | |_| | |
> http://www.aiinet.com/     |__/|_|_|

Could you send this to the ppp list as well?

Also, it is old style K&R C code, perhaps you could convert it to current taste.
