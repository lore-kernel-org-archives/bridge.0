Return-Path: <pablo@netfilter.org>
Date: Fri, 5 Jul 2019 22:44:02 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190705204402.u7rhjzgghv56evuf@salvia>
References: <1562332598-17415-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562332598-17415-1-git-send-email-wenxu@ucloud.cn>
Subject: Re: [Bridge] [PATCH 1/7 nf-next v2] netfilter: separate bridge meta
 key from nft_meta into meta_bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wenxu@ucloud.cn
Cc: nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

On Fri, Jul 05, 2019 at 09:16:32PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> Separate bridge meta key from nft_meta to meta_bridge for other key
> support. So there is n dependency between nft_meta and the bridge
> module

Applied, thanks.
