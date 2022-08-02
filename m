Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3AA828136A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0232B81366
MIME-Version: 1.0
Date: Tue, 02 Aug 2022 14:54:50 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20220721115935.5ctsbtoojtoxxubi@skbuf>
References: <20220708091550.2qcu3tyqkhgiudjg@skbuf>
 <e3ea3c0d72c2417430e601a150c7f0dd@kapio-technology.com>
 <20220708115624.rrjzjtidlhcqczjv@skbuf>
 <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
 <648ba6718813bf76e7b973150b73f028@kapio-technology.com>
 <YtQosZV0exwyH6qo@shredder>
 <4500e01ec4e2f34a8bbb58ac9b657a40@kapio-technology.com>
 <20220721115935.5ctsbtoojtoxxubi@skbuf>
Message-ID: <a49aa436546d9e59116765ef424ab894@kapio-technology.com>
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 2022-07-21 13:59, Vladimir Oltean wrote:
> On Sun, Jul 17, 2022 at 05:53:22PM +0200, netdev@kapio-technology.com 
> wrote:
>> > 3. What happens to packets with a DA matching the zero-DPV entry, are
>> > they also discarded in hardware? If so, here we differ from the bridge
>> > driver implementation where such packets will be forwarded according to
>> > the locked entry and egress the locked port
>> 
>> I understand that egress will follow what is setup with regard to UC, 
>> MC and
>> BC, though I haven't tested that. But no replies will get through of 
>> course
>> as long as the port hasn't been opened for the iface behind the locked 
>> port.
> 
> Here, should we be rather fixing the software bridge, if the current
> behavior is to forward packets towards locked FDB entries?

Yes, I think that locked entries should block egress to the respective 
hosts behind the locked port, which should be fixed in the bridge.
