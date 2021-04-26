Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElITN/SEJa7a510AWVg3PsY9eUAEFGGK8FAip/Gkb5Q=;
 b=uSFWwwKhoa73x37R/1HkzHIa3k3VD+FsFJoEaHF+kdrv8owPT9K8PTkj/D0PKN+9cQZjmVG02LBr3CscNk1IHPLul7sn9ssYdXCJKUJdszTA8yfbtiGD9KjxKk+9OWlvsZDhXOMXngwo5ViAblVWiUVZLsgdmgZoiS9EfsTgnLDHnLvMy4lehRuxsQUCpXpJ4rigEshJiOaVeLs3FuH5TSZyAvJfAd8y5AmWgGPguuxSw2G01Zvb8Se9xxoDoMb7FcmGahwiBwNvnuM2J84UnO9kXVpfYcFwKSCGoMEVcwelOve81z3KzIBV2xlelQYYQcwCz0FXT9sBXXgwn3mgYQ==
References: <20210425155742.30057-1-ap420073@gmail.com>
 <20210425155742.30057-3-ap420073@gmail.com>
 <ed54816f-2591-d8a7-61d8-63b7f49852c1@nvidia.com>
 <20210426124806.4zqhtn4wewair4ua@gondor.apana.org.au>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <1e8cda49-4bc3-6f0b-29f3-97848aab18f0@nvidia.com>
Date: Mon, 26 Apr 2021 16:15:42 +0300
In-Reply-To: <20210426124806.4zqhtn4wewair4ua@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net 2/2] net: bridge: fix lockdep
 multicast_lock false positive splat
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: bridge@lists.linux-foundation.org, cong.wang@bytedance.com, daniel@iogearbox.net, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, dsahern@kernel.org, roopa@nvidia.com, ast@kernel.org, bjorn@kernel.org, vfalico@gmail.com, j.vosburgh@gmail.com, kuba@kernel.org, weiwan@google.com, andriin@fb.com, davem@davemloft.net, Taehee Yoo <ap420073@gmail.com>

On 26/04/2021 15:48, Herbert Xu wrote:
> On Sun, Apr 25, 2021 at 07:45:27PM +0300, Nikolay Aleksandrov wrote:
>>
>> Ugh.. that's just very ugly. :) The setup you've described above is by all means invalid, but
>> possible unfortunately. The bridge already checks if it's being added as a port to another
>> bridge, but not through multiple levels of indirection. These locks are completely unrelated
>> as they're in very different contexts (different devices).
> 
> Surely we should forbid this? Otherwise what's to stop someone
> from creating a loop?
> 
> Cheers,
> 

Indeed that would be best, it's very easy to loop them.



