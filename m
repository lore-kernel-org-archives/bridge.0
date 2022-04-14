Return-Path: <dsahern@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649896946;
 bh=8lYIYTMcMRpADQYVwwEbTQ7w7xq7gDAawhUe2eXrNFo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=V9J3P/MYXS5MyBbY7MTCPsrfE3nENIideBDr+z1NaP1bcBCdbI3rgl5AU0FWbmsLZ
 62EnjksFq+LNx4NUgcKoemXlmZv8EmHHOxnTPP1I+62tLeAZw//HUYCtw8T9CFBHIe
 Xjzn4NWjVlQ4eY0G9WRzvMmR17iTAnF78k+Mwr1KzmT5JQIND3vvBajDHYMbRFLwmO
 lNodux6lTYtTYALdmZYoqdOA1g4qIOqgxJMAOLVNXYymjK3WSLJapuNHblHxwjOcR9
 ECdhgOhZnf68tHU/+aHapN3TtclDep2M8NkIjdAdN/7R/L6o7n4lRkO9p0kl1zHvE0
 ztYWtas8r600Q==
Message-ID: <97774474-65a3-fa45-e0b9-8db6c748da28@kernel.org>
Date: Wed, 13 Apr 2022 18:42:24 -0600
MIME-Version: 1.0
Content-Language: en-US
References: <20220413105202.2616106-1-razor@blackwall.org>
 <20220413105202.2616106-6-razor@blackwall.org> <Yla8wj7khYxpwxan@shredder>
 <e43b5033-d350-fc81-71be-de3e1053c72a@blackwall.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <e43b5033-d350-fc81-71be-de3e1053c72a@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 05/12] net: rtnetlink: add bulk
 delete support flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com

On 4/13/22 6:21 AM, Nikolay Aleksandrov wrote:
>> If a buggy user space application is sending messages with NLM_F_BULK
>> set (unintentionally), will it break on newer kernel? I couldn't find
>> where the kernel was validating that reserved flags are not used (I
>> suspect it doesn't).
> 
> Correct, it doesn't.
> 
>>
>> Assuming the above is correct and of interest, maybe just emit a warning
>> via extack and drop the goto? Alternatively, we can see if anyone
>> complains which might never happen
>>
> 
> TBH I prefer to error out on an unsupported flag, but I get the problem. These
> weren't validated before and we start checking now. The problem is that we'll
> return an extack without an error, but the delete might also remove something.
> Hrm.. perhaps we can rephrase the error in that case (since it becomes a warning
> in iproute2 terms):
>  "NLM_F_BULK flag is set but bulk delete operation is not supported"
> So it will warn the user it has an unsupported flag.
> 
> WDYT ?
> 
> IMO we should bite the bullet and keep the error though. :)
> 

I agree. The check across the board for BULK flag on any DELETE requests
should tell us pretty quick if someone is setting that flag when it
should not be.
