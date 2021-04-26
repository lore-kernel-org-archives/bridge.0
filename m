Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAyIvH6kpfBCfm7Rp6bKOWHb7tzs1amp6FWoqm48lZQ=;
 b=aHTjqgyQ7FJFT/RKoMfaeoO3ywCLgGhGjh9G3Tnwy84jOUQzoSEMPlSfbnFOEQ0PLH5CW/3vNjT0JSrFyAugK+QB5oMqr+NqP8oMARIiG+vfua0EyBbM/H7L7o6K9Hw+3tSg31lmyKBRzsjPwE7pDXl96VZZp8/D5YUCikJ9n4ruCtcYWFqpghPlwOh8oxYWf1ZUJTAzlAU7/kTR8K0kb2+0Dwr7HIoJjgSKIAIq/BUA4PC6I0u1q+t4T8XwvxSlWkrVi8V0Q2OhrUyvB9+S//A+d7AfI5dGscemp1RATOMUsUiUky0xfX0Y9+keenwpMKGGbhmRUeSiCJxrk2yTyQ==
References: <20210425155742.30057-1-ap420073@gmail.com>
 <20210425155742.30057-3-ap420073@gmail.com>
 <ed54816f-2591-d8a7-61d8-63b7f49852c1@nvidia.com>
 <20210426124806.4zqhtn4wewair4ua@gondor.apana.org.au>
 <1e8cda49-4bc3-6f0b-29f3-97848aab18f0@nvidia.com>
 <68b18d15-d472-3305-4f91-5e61f8b60488@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <a1c51f0a-314b-fecb-7ba7-cd10f3a53a53@nvidia.com>
Date: Mon, 26 Apr 2021 18:39:19 +0300
In-Reply-To: <68b18d15-d472-3305-4f91-5e61f8b60488@gmail.com>
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
To: Taehee Yoo <ap420073@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: bridge@lists.linux-foundation.org, cong.wang@bytedance.com, daniel@iogearbox.net, yoshfuji@linux-ipv6.org, j.vosburgh@gmail.com, dsahern@kernel.org, roopa@nvidia.com, ast@kernel.org, bjorn@kernel.org, vfalico@gmail.com, netdev@vger.kernel.org, kuba@kernel.org, weiwan@google.com, andriin@fb.com, davem@davemloft.net

On 26/04/2021 18:17, Taehee Yoo wrote:
> On 4/26/21 10:15 PM, Nikolay Aleksandrov wrote:
>> On 26/04/2021 15:48, Herbert Xu wrote:
> 
> Hi Nikolay and Herbert,
> Thank you for the reviews!
> 
>>> On Sun, Apr 25, 2021 at 07:45:27PM +0300, Nikolay Aleksandrov wrote:
>>>>
>>>> Ugh.. that's just very ugly. :) The setup you've described above is by all means invalid, but
>>>> possible unfortunately. The bridge already checks if it's being added as a port to another
>>>> bridge, but not through multiple levels of indirection. These locks are completely unrelated
>>>> as they're in very different contexts (different devices).
>>>
>>> Surely we should forbid this? Otherwise what's to stop someone
>>> from creating a loop?
>>>
>>> Cheers,
>>>
>>
>> Indeed that would be best, it's very easy to loop them.
>>
> 
> We can make very various interface graphs with master/slave interface types.
> So, if we need something to forbid it, I think it should be generic code, not only for the bridge module.

Forbidding bridge nesting would be the correct fix. I'm surprised this is the
only lock you've seen a splat about, I'd like to avoid littering the code with
these custom lock helpers when it's correct. Moreover stacking most interfaces
is fine even if it doesn't make any sense, but in this case (there probably are
others too) we have to forbid it because looping 2 bridges is obviously bad.

Cheers,
 Nik


