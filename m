Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=BM5k0kkio2R7Vcb1AP2k6RxRHMZpGAV0eFzOrb5l0VY=;
	b=CxGbbW632YVjM54WJhzdY/VDJPMZY+qNFwBjnmXzA6q5pYuSZPdNDkk9bqDC5qijPd
	IFllT808pft27PzZDzWHtSvheLToF0BNRPE2dcHuTwXGqajpo+B8wiD6hMMjNBfk94Fz
	jc9Lnrjg+F1val7zXWpuHLsC2yo2GWEdiZbFk=
References: <20190703124040.19279-1-pablo@netfilter.org>
	<ecb6d9e8-7923-07ba-8940-c69fc251f4c3@ucloud.cn>
	<20190703141507.mnhzqapu4iaan5d7@salvia>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <3df24a0e-fd51-2dee-8cd3-76daf2ea9de7@cumulusnetworks.com>
Date: Wed, 3 Jul 2019 17:52:12 +0300
MIME-Version: 1.0
In-Reply-To: <20190703141507.mnhzqapu4iaan5d7@salvia>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] netfilter: nft_meta: fix bridge port vlan ID
	selector
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>, wenxu <wenxu@ucloud.cn>
Cc: bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

On 03/07/2019 17:15, Pablo Neira Ayuso wrote:
> Hi,
> 
> I'm planning to revert from nf-next
> 
>         da4f10a4265b netfilter: nft_meta: add NFT_META_BRI_PVID support
> 
> because:
> 
> * Nikolay wants us to use the helpers, however, through the existing
>   approach this creates a dependency between nft_meta and the bridge
>   module. I think I suggested this already, but it seems there is a
>   need for nft_meta_bridge, otherwise nft_meta pulls in the bridge
>   modules as a dependency.
> 
> * NFT_META_BRI_PVID needs to be rename to NFT_META_BRI_IIFPVID.
> 
> * We need new helpers to access this information from rcu path, I'm
>   attaching a patch for such helper for review.
> 
> so we take the time to get this right :-)
> 

Hi,
The plan sounds good to me. I also went over the patch and it looks good.
I think it'd be nice if we can get rid of the br_private.h include and
make nft_meta (or meta_bridge) use linux/if_bridge.h instead. Having
a clear distinction between what is supposed to be exported and what
remains internal would be great. I will help out with that.

Thanks,
 Nik

