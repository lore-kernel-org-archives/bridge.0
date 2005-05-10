Date: Tue, 10 May 2005 14:52:48 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Port link status disconnect
Message-ID: <20050510145248.6041a7c8@dxpl.pdx.osdl.net>
In-Reply-To: <6.1.2.0.2.20050510115447.043b4c90@luna.tlmat.unican.es>
References: <427D8B20.7010301@SiuLung.com>
	<6.1.2.0.2.20050509184627.05a787d0 @luna.tlmat.unican.es>
	<20050509105035.5f1c945f@dxpl.pdx.osdl.net>
	<6.1.2.0.2.20050510115447.043b4c90@luna.tlmat.unican.es>
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
To: Jorge Lanza <jlanza@tlmat.unican.es>
Cc: bridge@lists.osdl.org

On Tue, 10 May 2005 11:59:48 +0200
Jorge Lanza <jlanza@tlmat.unican.es> wrote:

> 
> At 19:50 09/05/2005, Stephen Hemminger wrote:
>  >On Mon, 09 May 2005 18:59:54 +0200
>  >Jorge Lanza <jlanza@tlmat.unican.es> wrote:
>  >>
>  >> As you can see I set the eth2 ip address to 0.0.0.0. However after a while
>  >> the eth2 returns by it self to the previous configured IP address (i.e.
>  >> 128.0.1.50). So, in order to make things work in the correct way I have to
>  >> retype ifconfig eth2 0.0.0.0 and the second time seems that everything
>  >> works as expected and the eth2 doesn't go back to the previous state.
>  >>
>  >> Why does it happen? What can I do? I need the device not to "get out of 
> the
>  >> brigde" and reconfigured. I have try to brctl br0 setfd 0  but still have
>  >> the same problem.
>  >>
>  >
>  >Probably you have eth2 configured in the normal distribution network
>  >configuration
>  >and the hotplug scripts are detecting the transition and setting it back.
>  >
>  >You need to make sure eth interfaces are not configured by other means.
> 
> Thanks very much, but the problem now is that I don't understand how to do 
> what you tell me.
> Could you give me some hints on it? It would be grateful if you could do so.

What distribution of linux are you using? Redhat, Fedora, Debian, Suse?
