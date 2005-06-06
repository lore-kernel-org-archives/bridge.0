Date: Mon, 6 Jun 2005 10:55:34 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050606105534.3d73afa7@dxpl.pdx.osdl.net>
In-Reply-To: <20050606105333.BF827443A4@service.i-think-future.de>
References: <20050606105333.BF827443A4@service.i-think-future.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: kernel 2.6.x.y + bridging operational?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Nils Radtke <Nils.Radtke@Think-Future.de>, bridge@osdl.org

On Mon, 6 Jun 2005 12:53:33 +0200
Nils Radtke <Nils.Radtke@Think-Future.de> wrote:

> 
>   Hi Stephen,
> 
>  the transition from kernels of the 2.4.x series to 2.6 series ones broke
>  my bridge. And other peoples bridges additionally, as I learned from 
>  various emails I received adressing this problem.

"broke" is not a complete description of the problem.  Did it not boot?
Not forward packets? Crash, please be more precise.  Also what emails
on what list, the official Linux network developers list is netdev@oss.sgi.com
and the bridge mailing list is bridge@osdl.org.

Also, which functionality? Bridging or bridging and filtering (netfilter).


>  I'd like to see clear about the why and where.
>  Could you give me any hints? 
>  The setup that worked previously is a std one. Two ethx ifs below the
>  br0 if.
> 
>  Afterwards, I'll update my HOWTO
>  (http://www.think-future.de/DOCUMENTATION/Ethernet-Bridge-netfilter-HOWTO/)
>

The current site to look for about netfilter and bridging is the ebables.sourceforge.net
info.


>  Thanks for your hints,
> 
>     Nils
> 
> BTW: on http://bridge.sourceforge.net/links.html the link to the HOWTO
>  leads to tldp.org basically ok, but the tldp people do not manage the
>  update I sent to them so the tldp version of my HOWTO is horribly
>  outdated. The above link (leading to think-future.de) reflects the
>  actual HOWTO's version. So you might update your link section leading
>  to the actual one.
>

I'll cleanup the site some time soon and get rid of old links thanks.
