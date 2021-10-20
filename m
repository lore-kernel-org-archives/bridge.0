Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RihB78LHNG8yCF8rC7fVPzBAu2JZPGnQi2Ytje75HqM=;
 b=deTHw27Cd8GfnWXU2gqw/saUg6kRHuP/SxoqxYY8JhcrB2MK4iwLm6vtUWDAG9XctJ9qo5EhAvc6RM2ElLLBEmS9brjMEx1rldkMKDZymq/s8IxiL3TT0+3TMuEfMAJxaxLrT5ooeSKo7HfC6d2KTF5c9w7V3BlMGQ+J6+DvwhSqCyiZDpAyjjp0kj4WV86ZCBLYBLVqu/3jgvN7fejhPAwXzsd3hCkJzPOn3HInwQRjAWzty6BAAIgLrlAAlqYPrtLNFFWRd/OLybkvI+LcwAexQnF8BzUZvCVzEwJBazd0oLmOVL6zHvZjIUp4rcWmMWx2dJ3P0SKxLSigRYgHag==
Message-ID: <bc778829-1fd3-f108-020b-85440e55f116@nvidia.com>
Date: Wed, 20 Oct 2021 15:14:54 +0300
Content-Language: en-US
References: <20211020023604.695416-1-liuhangbin@gmail.com>
 <20211020024016.695678-1-liuhangbin@gmail.com>
 <c041a184-92cb-0ebd-25e9-13bfc6413fc9@nvidia.com>
 <YW/tLekS17ZF9/w1@Laptop-X1> <YXAHHBYtFfXbd1hE@Laptop-X1>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <YXAHHBYtFfXbd1hE@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCHv2 net] net: bridge: mcast: QRI must be less
	than QI
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On 20/10/2021 15:10, Hangbin Liu wrote:
> On Wed, Oct 20, 2021 at 06:19:25PM +0800, Hangbin Liu wrote:
>> On Wed, Oct 20, 2021 at 12:49:17PM +0300, Nikolay Aleksandrov wrote:
>>> Nacked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
>>>
>>> I think we just discussed this a day ago? It is the same problem -
>>> while we all agree the values should follow the RFC, users have had
>>> the option to set any values forever (even non-RFC compliant ones).
>>> This change risks breaking user-space.
>>
>> OK, I misunderstood your reply in last mail. I thought you only object to
>> disabling no meaning values(e.g. set timer to 0, which not is forbid by the
>> RFC). I don't know you also reject to follow a *MUST* rule defined in the RFC.
> 
> I know you denied the patch due to user-space compatibility. Forgive me
> if my last reply sound a little aggressive.
> 
> Thanks
> Hangbin
> 

No worries. :) I obviously agree that it should be RFC compliant, but we must do it
in a different way that doesn't risk breaking users, it goes also for how the values are
computed. In the future when more of the RFC is implemented we might need to force
compliance and that might require adding a new option, I guess we'll see when we get there.

Cheers,
 Nik

