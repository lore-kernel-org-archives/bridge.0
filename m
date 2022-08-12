Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3910C40C5C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 284E840C10
MIME-Version: 1.0
Date: Fri, 12 Aug 2022 17:33:58 +0200
From: netdev@kapio-technology.com
In-Reply-To: <YvTn847P/Ga3Ulb0@shredder>
References: <20220708115624.rrjzjtidlhcqczjv@skbuf>
 <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
 <79683d9cf122e22b66b5da3bbbb0ee1f@kapio-technology.com>
 <YvIm+OvXvxbH6POv@shredder>
 <6c6fe135ce7b5b118289dc370135b0d3@kapio-technology.com>
 <YvNcitNnyFxTw8bs@shredder>
 <2491232d5c017d94ca3213197a3fb283@kapio-technology.com>
 <YvTn847P/Ga3Ulb0@shredder>
Message-ID: <a36d6891ce8e961c24987a424b6d7b66@kapio-technology.com>
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
>> >
>> > I'm talking about roaming, not forwarding. Let's say you have a locked
>> > entry with MAC X pointing to port Y. Now you get a packet with SMAC X
>> > from port Z which is unlocked. Will the FDB entry roam to port Z? I
>> > think it should, but at least in current implementation it seems that
>> > the "locked" flag will not be reset and having locked entries pointing
>> > to an unlocked port looks like a bug.
>> >

Yes, now I have tried to test with a case like this using the bridge and 
have verified the locked entry pointing to an unlocked port, which I 
agree seems to be a bug, which I will get fixed.
