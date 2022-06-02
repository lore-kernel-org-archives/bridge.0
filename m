Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=jLhgLLgTKtoWPjtFp8qSJCOCQYPPUCR4lznJBFvpJ40=;
 b=U2/PO1uNjGw4COGMRK/7YnRCnLhzHnfNDU3fAZ5Gx+P/GW9LrdqG3I45ITG643pzdb
 JG96C8RFIxHaJo6jdq6DH8J0mqrH0Bz1LFAyLJSsLa4UaZpclulO0L4GHi+89g9+1pnR
 HDM6h3Y5186RpYH4+PvFGvDR2Ik+oyncwi5oGmQCSvo+gPTdzOt12QXk6cniH/TCtech
 Vq3liKmSG0Xman0T2LN3WT0Wj/eUgaio4p3CEkzLOQrTkoGzCA/fMFr6AeOL1HJpIUZ2
 C0wbKaR6CbkPBGYPA6Dz6XgoxKgg/nkvNXlWjX0lgXr+zdmUXLKioQVm/Tf/NW942v7j
 a/3A==
Message-ID: <d88b6090-2ac8-0664-0e38-bb2860be7f6e@blackwall.org>
Date: Thu, 2 Jun 2022 12:33:34 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
 <Yo+LAj1vnjq0p36q@shredder> <86sfov2w8k.fsf@gmail.com>
 <YpCgxtJf9Qe7fTFd@shredder> <86sfoqgi5e.fsf@gmail.com>
 <YpYk4EIeH6sdRl+1@shredder> <86y1yfzap3.fsf@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <86y1yfzap3.fsf@gmail.com>
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

On 02/06/2022 12:17, Hans Schultz wrote:
> On tis, maj 31, 2022 at 17:23, Ido Schimmel <idosch@nvidia.com> wrote:
>> On Tue, May 31, 2022 at 11:34:21AM +0200, Hans Schultz wrote:
>>>> Just to give you another data point about how this works in other
>>>> devices, I can say that at least in Spectrum this works a bit
>>>> differently. Packets that ingress via a locked port and incur an FDB
>>>> miss are trapped to the CPU where they should be injected into the Rx
>>>> path so that the bridge will create the 'locked' FDB entry and notify it
>>>> to user space. The packets are obviously rated limited as the CPU cannot
>>>> handle billions of packets per second, unlike the ASIC. The limit is not
>>>> per bridge port (or even per bridge), but instead global to the entire
>>>> device.
>>>
>>> Btw, will the bridge not create a SWITCHDEV_FDB_ADD_TO_DEVICE event
>>> towards the switchcore in the scheme you mention and thus add an entry
>>> that opens up for the specified mac address?
>>
>> It will, but the driver needs to ignore FDB entries that are notified
>> with locked flag. I see that you extended 'struct
>> switchdev_notifier_fdb_info' with the locked flag, but it's not
>> initialized in br_switchdev_fdb_populate(). Can you add it in the next
>> version?
> 
> An issue with sending the flag to the driver is that port_fdb_add() is
> suddenly getting more and more arguments and getting messy in my
> opinion, but maybe that's just how it is...
> 
> Another issue is that
> bridge fdb add MAC dev DEV master static
> seems to add the entry with the SELF flag set, which I don't think is
> what we would want it to do or?

I don't see such thing (hacked iproute2 to print the flags before cmd):
$ bridge fdb add 00:11:22:33:44:55 dev vnet110 master static
flags 0x4

0x4 = NTF_MASTER only

> Also the replace command is not really supported properly as it is. I
> have made a fix for that which looks something like this:
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 6cbb27e3b976..f43aa204f375 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -917,6 +917,9 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>                 if (flags & NLM_F_EXCL)
>                         return -EEXIST;
>  
> +               if (flags & NLM_F_REPLACE)
> +                       modified = true;
> +
>                 if (READ_ONCE(fdb->dst) != source) {
>                         WRITE_ONCE(fdb->dst, source);
>                         modified = true;
> 
> The argument for always sending notifications to the driver in the case
> of replace is that a replace command will refresh the entries timeout if
> the entry is the same. Any thoughts on this?

I don't think so. It always updates its "used" timer, not its "updated" timer which is the one
for expire. A replace that doesn't actually change anything on the entry shouldn't generate
a notification.
