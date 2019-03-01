Return-Path: <pablo@netfilter.org>
Date: Fri, 1 Mar 2019 14:32:30 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190301133230.xccq7quitjqr4p3d@salvia>
References: <1550843152-1772-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550843152-1772-1-git-send-email-lirongqing@baidu.com>
Subject: Re: [Bridge] [PATCH][nf-next][v2] netfilter: convert the proto
 argument from u8 to u16
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

On Fri, Feb 22, 2019 at 09:45:52PM +0800, Li RongQing wrote:
> The proto in struct xt_match and struct xt_target is u16, when
> calling xt_check_target/match, their proto argument is u8,
> and will cause truncation, it is harmless to ip packet, since
> ip proto is u8
> 
> if a etable's match/target has proto that is u16, will cause
> the check failure.
> 
> and convert be16 to short in bridge/netfilter/ebtables.c

Applied, thanks.
