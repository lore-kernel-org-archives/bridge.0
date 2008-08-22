Date: Fri, 22 Aug 2008 19:50:10 -0400
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080822195010.601d1873@speedy>
In-Reply-To: <35768C4F0D45AD45BAB2832E96E079E30179BF@newposiserver.Positronics.local>
References: <35768C4F0D45AD45BAB2832E96E079E30179BF@newposiserver.Positronics.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge-utils and ppp
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kelvin Chan <kelvinc@positronics.com>, bridge@linux-foundation.org

On Thu, 21 Aug 2008 17:44:59 -0700
"Kelvin Chan" <kelvinc@positronics.com> wrote:

> Hi Stephen,
> 
> --god, I hate outlook. Sorry, was trying to insert an line break
> but instead sent the email. --
> 
> I'm trying to create an multicast enabled Ethernet bridge using ppp
> and brctl. 
> 
> I tried:
> brctl addbr br0
> brctl addif eth0
> brctl addif ppp0
> 
> after last command, I get:
> can't add ppp0 to bridge br0: Invalid argument
> 
> both eth0 and ppp0 are up and have an address. I googled around 
> and found this an issue with the kernel bridge code. However, in 
> Linux Foundation's bridge-utils documentation, it didn't mention
> the required kernel version. I'm running 2.6.18 from Debian Etch.
> 
> Can you give me any hints to bridge an ppp to eth device?
> 

Won't work because PPP is a tunneling interface so it doesn't
have an ethernet header required for bridging.  Layer 2 versus Layer 3 issue.
