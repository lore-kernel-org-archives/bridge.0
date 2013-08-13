Return-Path: <vyasevic@redhat.com>
Message-ID: <520ABBFD.7080004@redhat.com>
Date: Tue, 13 Aug 2013 19:06:37 -0400
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <52090C26.4090001@fiberby.net>
	<1376325009-8399-1-git-send-email-ast@fiberby.net>
	<52093E29.5010604@redhat.com>
	<20130813.155443.1789890841731289313.davem@davemloft.net>
In-Reply-To: <20130813.155443.1789890841731289313.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] rtnetlink: rtnl_bridge_getlink: Call
 nlmsg_find_attr() with ifinfomsg header
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, ast@fiberby.net, linux-kernel@vger.kernel.org

On 08/13/2013 06:54 PM, David Miller wrote:
> From: Vlad Yasevich <vyasevic@redhat.com>
> Date: Mon, 12 Aug 2013 15:57:29 -0400
>
>> On 08/12/2013 12:30 PM, Asbjoern Sloth Toennesen wrote:
>>> Fix the iproute2 command `bridge vlan show`, after switching from
>>> rtgenmsg to ifinfomsg.
>>>
>>> Signed-off-by: Asbjoern Sloth Toennesen <ast@fiberby.net>
>>
>>
>> Thanks..  I've still been using an older iproute version and didn't
>> see this.
>>
>>
>> Reviewed-by: Vlad Yasevich <vyasevich@gmail.com>
>
> What introduced this regression?
>

ast explained it in his header message (Bridge VLAN kernel/iproute2 
incompatibility)

-vlad
