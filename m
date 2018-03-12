Return-Path: <igor.mitsyanko.os@quantenna.com>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
	<20180310030308.12947-2-igor.mitsyanko.os@quantenna.com>
	<20180310083234.47db5f06@xeon-e3>
From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Message-ID: <9eba43b1-347f-f66a-2eef-999e249b3661@quantenna.com>
Date: Mon, 12 Mar 2018 12:03:10 -0700
MIME-Version: 1.0
In-Reply-To: <20180310083234.47db5f06@xeon-e3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/5] bridge: initialize port flags
 with switchdev defaults
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: ivecera@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

On 03/10/2018 08:32 AM, Stephen Hemminger wrote:
> Yes hardware devices may come it with different default values.
> But the user experience on Linux needs to be consistent.
> 
> Instead, it makes more sense to me for each device driver using switchdev
> to program to the values that it sees in the bridge.
> 
> Please revise this.
> 

Right, it does change default user view, setting flags instead of 
querying makes more sense then.

However there is a problem that switchdev may not support all flags that 
bridge code sets by default. For example, looking at 
spectrum_switchdev.c, it only advertises support for BR_LEARNING | 
BR_FLOOD | BR_MCAST_FLOOD.
Currently, I assume that even though some flags are shown as set by 
default on a new bridge port, some of them are not actually working in 
switchdev?
