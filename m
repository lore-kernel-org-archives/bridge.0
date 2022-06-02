Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=iabOKt8Lt4ClyBb4r4Q/KqHn7Cps1qrTWhdLROC0vws=;
 b=VQCl9uRJ1U9yzv+giXqEkz6Z1yMCqEp3hD2gW4Jaw5s1Ewt13S9ZakS15xCYWgi3dv
 xayD1UAWLjkxDApMnNgrFpkP1w09bQiGAG1jDOT96JEC8CsV4tlBXUJHtyiCTPMsiDZx
 Ayt7KUdq8NRJLYDz2WlL2v8d2xGg5Kc1SDjshNLy/xPvE3M4zaxkKtVQdbvoCpaT8Fwp
 zD8In4NBTo53lm8LB1BxmK9EXteWssgCifKEmDLsDDB4VC2y7OtAmcxx/TCoq8dQR+2r
 9Ma6Txx/6cNyejFL24zKary5+Wajx7zFRWu44J5LchvKYmsCy0hhGgqcVVhxQ0Qdw/dh
 EJxA==
Message-ID: <3d93d46d-c484-da0a-c12c-80e83eba31c9@blackwall.org>
Date: Thu, 2 Jun 2022 13:30:06 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
 <Yo+LAj1vnjq0p36q@shredder> <86sfov2w8k.fsf@gmail.com>
 <YpCgxtJf9Qe7fTFd@shredder> <86sfoqgi5e.fsf@gmail.com>
 <YpYk4EIeH6sdRl+1@shredder> <86y1yfzap3.fsf@gmail.com>
 <d88b6090-2ac8-0664-0e38-bb2860be7f6e@blackwall.org>
 <86sfonjroi.fsf@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <86sfonjroi.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH V3 net-next 1/4] net: bridge: add fdb flag to
 extent locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 02/06/2022 13:17, Hans Schultz wrote:
> On tor, jun 02, 2022 at 12:33, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>> On 02/06/2022 12:17, Hans Schultz wrote:
>>> On tis, maj 31, 2022 at 17:23, Ido Schimmel <idosch@nvidia.com> wrote:
>>>> On Tue, May 31, 2022 at 11:34:21AM +0200, Hans Schultz wrote:
> 
>>> Another issue is that
>>> bridge fdb add MAC dev DEV master static
>>> seems to add the entry with the SELF flag set, which I don't think is
>>> what we would want it to do or?
>>
>> I don't see such thing (hacked iproute2 to print the flags before cmd):
>> $ bridge fdb add 00:11:22:33:44:55 dev vnet110 master static
>> flags 0x4
>>
>> 0x4 = NTF_MASTER only
>>
> 
> I also get 0x4 from iproute2, but I still get SELF entries when I look
> with:
> bridge fdb show dev DEV
> 

after the above add:
$ bridge fdb show dev vnet110 | grep 00:11
00:11:22:33:44:55 master virbr0 static

>>> Also the replace command is not really supported properly as it is. I
>>> have made a fix for that which looks something like this:
>>>
>>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>>> index 6cbb27e3b976..f43aa204f375 100644
>>> --- a/net/bridge/br_fdb.c
>>> +++ b/net/bridge/br_fdb.c
>>> @@ -917,6 +917,9 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>>>                 if (flags & NLM_F_EXCL)
>>>                         return -EEXIST;
>>>  
>>> +               if (flags & NLM_F_REPLACE)
>>> +                       modified = true;
>>> +
>>>                 if (READ_ONCE(fdb->dst) != source) {
>>>                         WRITE_ONCE(fdb->dst, source);
>>>                         modified = true;
>>>
>>> The argument for always sending notifications to the driver in the case
>>> of replace is that a replace command will refresh the entries timeout if
>>> the entry is the same. Any thoughts on this?
>>
>> I don't think so. It always updates its "used" timer, not its "updated" timer which is the one
>> for expire. A replace that doesn't actually change anything on the entry shouldn't generate
>> a notification.
> 
> Okay, so then there is missing checks on flags as the issue arose from
> replacing locked entries with dynamic entries. I will do another fix
> based on flags as modified needs to be true for the driver to get notified.

