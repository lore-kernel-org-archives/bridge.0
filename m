Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645721288;
 bh=8JTPR/7vjk4EMGQfh0ixKzqy+71HD3b6jjnIvvGYOc4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iEfpodCNLQqMB82z/KU0/MV9yw7n62gF7C1iFWf4TWnmCIKPY9Md7z2G+GZxXyCwY
 Sw/hm6nQQwtMVJy74HMSwByyrhJ+A0BmnUVqVcUSStBN/AqJHTClwuNbE73HrZX9P/
 LWNiEznOCqWwSj/RyBFddMQgOL/llz7nL1X/usX8hPA+RX2zwiCYsCNvZoF5G0ohgC
 p9ZhqdB6imNSDAJ7NVHX9cyEOo5Lu1vybrAFrz8LjdiWGydMgau6A/yB6eOsHQUtxf
 lROxdsQkCYOm3wmckh3tryJG/GddPSSLgHujlc/JBvCUfm7qF9b8V/2GqZMn7KhQPN
 N31WF13sI8JJg==
Date: Thu, 24 Feb 2022 08:48:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220224084806.4e85e6b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <875yp4qlcg.fsf@gmail.com>
References: <20220223172407.175865-1-troglobit@gmail.com>
 <66dc205f-9f57-61c1-35d9-8712e8d9fe3a@blackwall.org>
 <20220224080611.4e32bac3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <875yp4qlcg.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/1 net-next] net: bridge: add support for host
 l2 mdb entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joachim Wiberg <troglobit@gmail.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, Roopa Prabhu <roopa@nvidia.com>

On Thu, 24 Feb 2022 17:29:35 +0100 Joachim Wiberg wrote:
> On Thu, Feb 24, 2022 at 08:06, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Thu, 24 Feb 2022 13:26:22 +0200 Nikolay Aleksandrov wrote:  
> >> On 23/02/2022 19:24, Joachim Wiberg wrote:  
>  [...]  
> >> It would be nice to add a selftest for L2 entries. You can send it as a follow-up.  
> > Let's wait for that, also checkpatch says you need to balance brackets
> > to hold kernel coding style.  
> 
> Jakub, by "wait for that" do you mean you'd prefer I add the selftests
> to this?

Yes, add a selftest as a separate patch but in the same series.
