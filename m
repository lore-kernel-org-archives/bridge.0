Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CD9160736
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 096AA605DB
MIME-Version: 1.0
Date: Mon, 01 Aug 2022 13:57:10 +0200
From: netdev@kapio-technology.com
In-Reply-To: <Yt0ouiEcAHs8AqAA@shredder>
References: <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
 <648ba6718813bf76e7b973150b73f028@kapio-technology.com>
 <YtQosZV0exwyH6qo@shredder>
 <4500e01ec4e2f34a8bbb58ac9b657a40@kapio-technology.com>
 <20220721115935.5ctsbtoojtoxxubi@skbuf> <YtlUWGdgViyjF6MK@shredder>
 <20220721142001.twcmiyvhvlxmp24j@skbuf> <Yt0ouiEcAHs8AqAA@shredder>
Message-ID: <474a24ff806bfb8142f3e65eecc665e7@kapio-technology.com>
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

On 2022-07-24 13:10, Ido Schimmel wrote:
> On Thu, Jul 21, 2022 at 05:20:01PM +0300, Vladimir Oltean wrote:
>> On Thu, Jul 21, 2022 at 04:27:52PM +0300, Ido Schimmel wrote:
>> > I tried looking information about MAB online, but couldn't find
>> > detailed material that answers my questions, so my answers are based
>> > on what I believe is logical, which might be wrong.
>> 
>> I'm kind of in the same situation here.
> 
> :(
> 

Sorry for being off here a while... here is my best link regarding MAB. 
Maybe it can answer some of your questions...

https://www.cisco.com/c/en/us/td/docs/solutions/Enterprise/Security/TrustSec_1-99/MAB/MAB_Dep_Guide.html#wp392522
