Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 553176114A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D52F61142
MIME-Version: 1.0
Date: Fri, 12 Aug 2022 14:29:48 +0200
From: netdev@kapio-technology.com
Message-ID: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 3/6] drivers: net: dsa: add locked
 fdb entry flag to drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 2022-08-11 13:28, Ido Schimmel wrote:

>> > I'm talking about roaming, not forwarding. Let's say you have a locked
>> > entry with MAC X pointing to port Y. Now you get a packet with SMAC X
>> > from port Z which is unlocked. Will the FDB entry roam to port Z? I
>> > think it should, but at least in current implementation it seems that
>> > the "locked" flag will not be reset and having locked entries pointing
>> > to an unlocked port looks like a bug.
>> >
>> 

In general I have been thinking that the said setup is a network 
configuration error as I was arguing in an earlier conversation with 
Vladimir. In this setup we must remember that SMAC X becomes DMAC X in 
the return traffic on the open port. But the question arises to me why 
MAC X would be behind the locked port without getting authed while being 
behind an open port too?
In a real life setup, I don't think you would want random hosts behind a 
locked port in the MAB case, but only the hosts you will let through. 
Other hosts should be regarded as intruders.

If we are talking about a station move, then the locked entry will age 
out and MAC X will function normally on the open port after the timeout, 
which was a case that was taken up in earlier discussions.

But I will anyhow do some testing with this 'edge case' (of being behind 
both a locked and an unlocked port) if I may call it so, and see to that 
the offloaded and non-offloaded cases correspond to each other, and will 
work satisfactory.

I think it will be good to have a flag to enable the mac-auth/MAB 
feature, and I suggest just calling the flag 'mab', as it is short.

Otherwise I don't see any major issues with the whole feature as it is.
