Date: Thu, 4 Nov 2004 16:42:27 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20041104164227.67e5e028@zqx3.pdx.osdl.net>
In-Reply-To: <4839.1099563244@www16.gmx.net>
References: <4839.1099563244@www16.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Problems using kernel 2.6
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Thomas Franke <thomas-carsten.franke@gmx.de>, bridge@osdl.org

On Thu, 4 Nov 2004 11:14:04 +0100 (MET)
"Thomas Franke" <thomas-carsten.franke@gmx.de> wrote:

> Hi, 
>  
> first of all - sorry that I'm contacting directly, but I'm in time 
> critical situation ... hopefully you can help me. 
> I'm using SuSE 9.2 kernel 2.6.8-24.3-smp (latest version from suse) 
> I wanted to bringup a bridge on my machine. After setting up the bridge 
> (addbr, addif, addif, reset ips, bring bridge up, give bridge ip via dhcp) 
> the brindging machine can ping other machines on both sides of the bridge 
> (eth0 and eth1 outgoing). The other machines can ping the bridging machine 
> but can't ping each other. The bridging machine seems not to forward any 
> packets. Same setup on 2.4.22 - kernel and 1.0.4 - version of bridge-utils 
> it works fine. I've used the cvs version of bridge-utils for support of 
> 2.6-kernel. 
>  
> Perhaps you have an idea ? 

What is the state of the bridge with:
	brctl showstp br0
and are addresses showing up in forward table
	brctl showmacs br0


> Thx 
> Thomas Carsten   
> 
> -- 
> Geschenkt: 3 Monate GMX ProMail + 3 Top-Spielfilme auf DVD
> ++ Jetzt kostenlos testen http://www.gmx.net/de/go/mail ++
