Return-Path: <shemminger@vyatta.com>
Date: Tue, 3 Jan 2012 08:15:21 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20120103081521.2fec3a29@nehalam.linuxnetplumber.net>
In-Reply-To: <1325597164-13459-2-git-send-email-richard@nod.at>
References: <4F025A07.2000304@nod.at>
	<1325597164-13459-1-git-send-email-richard@nod.at>
	<1325597164-13459-2-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] netfilter: Fix br_nf_pre_routing() in
 conjunction with bridge-nf-call-ip(6)tables=0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org

On Tue,  3 Jan 2012 14:26:04 +0100
Richard Weinberger <richard@nod.at> wrote:

> If net.bridge.bridge-nf-call-iptables or net.bridge.bridge-nf-call-ip6tables
> are set to zero xt_physdev has no effect because skb->nf_bridge has not been set up.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

I am not sure if this is a valid configuration. The setting of sysctl is saying
"don't do iptables on bridge (since I won't be using it)" and then you are later
doing iptables and expecting the settings as if the iptables setup was being
done.

Instead, you should just enable the net.bridge.bridge-nf-call-iptables sysctl.
If a distro chooses to disable it then you may have to do it explicitly.

