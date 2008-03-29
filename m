From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
References: 
In-Reply-To: 
Date: Sat, 29 Mar 2008 18:10:24 +0100
Message-ID: <019201c891bf$c76a1b60$563e5220$@Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: sv
Subject: Re: [Bridge] RSTP in
	http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
	a=summary problems
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge@lists.linux-foundation.org

> -----Original Message-----
> From: Joakim Tjernlund [mailto:Joakim.Tjernlund@transmode.se]
> Sent: den 29 mars 2008 17:22
> To: 'Bridge@lists.linux-foundation.org'
> Subject: RSTP in http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;a=summary problems
> 
> Hi List
> 
> I cloned the above RSTP imp. and cross-compiled it to powerpc and tried
> in on my 2.6.23 kernel, but didn't get very far:
> 
> Created a bridge, br0, with brctl and added two interfaces.
> started rstpd without args and ran rstpctl
>   rstpctl showbridge br0
> and all I get is
>   CTL_get_bridge_state: Got return code 0, 1003
>   Failed to get bridge state: Err_Bridge_is_down
> 
> The br0 i/f is UP amd RUNNING and so is the interfaces I added.
> I probably forgot to do something I suppose, but what?
> 
>     Jocke

Never mind, user error on my part.

I do wonder though if rstpd is production ready or still needs more
testing/fixes?

   Jocke

