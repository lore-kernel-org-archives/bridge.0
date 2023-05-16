Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4AE1683C2B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D1C28405C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1684225622; x=1686817622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Q/Wa8M+8uvC4yapXeHr/mR9kOO52paWXj/dqyPoiGY=;
 b=QBexmk+DMOo6mdKn5THtfjbOH7Fh/sar7zK4I1M/u/4HUWDtu9v8bKl/3t18wSNBro
 oE12HbynSoEYrSJoElh+Zqa6TVqFxJnUthg+jxikGz9G+0tZm9NG0TzrFjZnaBTsDE3B
 vF0ucHloTC5lpw0cIFX+5JD1aKa8uqbrHr0rXsqjaGdGLkLxFD2z1nqHiT1TrJM5FaJJ
 8U3uLmynbkNmLLlbAV5ZjSote3XXh3ybIrOzP2PTcsCTdgV5QPc7iAJW7oawAOEPBQjQ
 CP5+zR7nyHQ1HenOE+ibGvpdguNwUmSETmCeALgAl0yuFiDU8IS76OZy6cdtEHTYwB+x
 lnPw==
Message-ID: <824ad48b-c419-fd21-1889-23cd94d4b75d@blackwall.org>
Date: Tue, 16 May 2023 11:27:00 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230515085046.4457-1-jnixdorf-oss@avm.de>
 <20230515085046.4457-2-jnixdorf-oss@avm.de>
 <dc8dfe0b-cf22-c4f9-8532-87643a6a9ceb@blackwall.org>
 <ZGIXB2DYA4sal9eW@u-jnixdorf.ads.avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZGIXB2DYA4sal9eW@u-jnixdorf.ads.avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/2] bridge: Add a sysctl to limit new
 brides FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 15/05/2023 14:27, Johannes Nixdorf wrote:
> On Mon, May 15, 2023 at 12:35:47PM +0300, Nikolay Aleksandrov wrote:
>> On 15/05/2023 11:50, Johannes Nixdorf wrote:
>>> This is a convenience setting, which allows the administrator to limit
>>> the default limit of FDB entries for all created bridges, instead of
>>> having to set it for each created bridge using the netlink property.
>>>
>>> The setting is network namespace local, and defaults to 0, which means
>>> unlimited, for backwards compatibility reasons.
>>>
>>> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
>>> ---
>>>  net/bridge/br.c         | 83 +++++++++++++++++++++++++++++++++++++++++
>>>  net/bridge/br_device.c  |  4 +-
>>>  net/bridge/br_private.h |  9 +++++
>>>  3 files changed, 95 insertions(+), 1 deletion(-)
>>>
>>
>> The bridge doesn't need private sysctls. Netlink is enough.
>> Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> Fair enough.
> 
> I originally included the setting so there is a global setting an
> administrator could toggle instead of having to hunt down each process
> that might create a bridge, and teaching them to create them with an
> FDB limit.
> 
> Does any of the following alternatives sound acceptable to you?:
>  - Having the default limit (instead of the proposed default to unlimited)
>    configurable in Kbuild. This would solve our problem, as we build
>    our kernels ourselves, but I don't know whether putting a limit there
>    would be acceptable for e.g. distributions.

I don't mind, but it would be useless for everyone else. Kernels would be built
without that limit set.

>  - Hardcoding a default limit != 0. I was afraid I'd break someones
>    use-case with far too large bridged networks if I don't default to
>    unlimited, but if you maintainers have a number in mind with which
>    you don't see a problem, I'd be fine with it as well.
> 
> (Sorry for sending this mail twice, I accidentally dropped the list and
> CC on the fist try)


Right, that has been discussed before. So far there hasn't been any good
option, so I'd say for the time being (or unless you have some better idea)
we should stick with the netlink max attribute and distributions/admins
would have to set it on bridge creation. We could add a warning when creating
a bridge without fdb limit to remind people that it's advisable to set it.
That warning can be removed when we come up with a proper solution.
