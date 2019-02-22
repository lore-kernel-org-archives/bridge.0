Return-Path: <fw@strlen.de>
Date: Fri, 22 Feb 2019 12:52:27 +0100
From: Florian Westphal <fw@strlen.de>
Message-ID: <20190222115227.mrqds7cawazelabn@breakpoint.cc>
References: <1550825471-32071-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550825471-32071-1-git-send-email-lirongqing@baidu.com>
Subject: Re: [Bridge] [PATCH][nf-next] netfilter: convert the proto argument
 from u8 to u16
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Li RongQing <lirongqing@baidu.com>
Cc: bridge@lists.linux-foundation.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org

Li RongQing <lirongqing@baidu.com> wrote:
> The proto in struct xt_match and struct xt_target is u16, when
> calling xt_check_target/match, their proto argument is u8,
> and will cause truncation, it is harmless to ip packet, since
> ip proto is u8
> 
> if a L2 match/target has proto that is u16, will cause the check
> failure.

Yes, I don't see any ebtables matches/targets that set .proto though, so
no failure should happen in current kernel.

Otherwise, could you add an example where we hit a checkentry failure in
error?

> +int xt_check_match(struct xt_mtchk_param *, unsigned int size, u_int16_t proto,
>  		   bool inv_proto);

I think you can use u16 instead of the old u_int16_t.

Other than that, this looks good to me, thanks.
