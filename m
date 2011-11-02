Return-Path: <shemminger@vyatta.com>
Date: Wed, 2 Nov 2011 13:14:45 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20111102131445.28a92335@nehalam.linuxnetplumber.net>
In-Reply-To: <CAPDOV48k=0c1anx7DC57u0x84tUVsFDQNO6=MiT+9eEE=Egi2A@mail.gmail.com>
References: <4EB19549.4010601@parallels.com>
	<20111102123106.107f4cb8@nehalam.linuxnetplumber.net>
	<CAPDOV48k=0c1anx7DC57u0x84tUVsFDQNO6=MiT+9eEE=Egi2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: Reset IPCB on forward non-local
 packets in br_handle_frame_finish()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Daniel Robbins <drobbins@funtoo.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Herbert Xu <herbert@gondor.hengli.com.au>, Vasily Averin <vvs@parallels.com>, "David S. Miller" <davem@davemloft.net>, devel@openvz.org

On Wed, 2 Nov 2011 13:45:29 -0600
Daniel Robbins <drobbins@funtoo.org> wrote:

> On Wed, Nov 2, 2011 at 1:31 PM, Stephen Hemminger <shemminger@vyatta.com> wrote:
> >
> > What kernel version are you using? There were several previous fixes
> > in br_netfilter to deal with this type of issue over the last year.
> 
> It's a kernel from this obscure company called Red Hat, and they
> include it in this product called Red Hat Enterprise Linux 6.
> 
> Specifically, 042stab37.1 :)
> 
> -Daniel

The pay for their tech support and have them fix it.
BTW - the problem was fixed upstream a long time ago, the upstream
kernel moves fast and RHEL probably froze many months before their
release.
