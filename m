Message-ID: <4851271B.8080304@trash.net>
Date: Thu, 12 Jun 2008 15:39:39 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <E88155B5BD67CE4D87A3F1F70950B96A2FF8A8@berta.maurer-it.com>	<20080611085859.721e3917@extreme>	<E88155B5BD67CE4D87A3F1F70950B96A2FF8AA@berta.maurer-it.com>	<4850FA96.1050205@trash.net>	<E88155B5BD67CE4D87A3F1F70950B96A2FF8AE@berta.maurer-it.com>
	<bdfc5d6e0806120622i7f55f960t891f8831ec71879b@mail.gmail.com>
In-Reply-To: <bdfc5d6e0806120622i7f55f960t891f8831ec71879b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge MAC selection
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andy Gospodarek <andy@greyhouse.net>
Cc: bridge@lists.linux-foundation.org

Andy Gospodarek wrote:
> On Thu, Jun 12, 2008 at 7:10 AM, Dietmar Maurer <dietmar@proxmox.com> wrote:
>>>>> There any side effects with the following patch?
>>>> Not for you. But if it got changed now, it would surprise the
>>>> existing users (change in ABI behaviour).
>> If there are no other side effects, I wonder whats better:
>>
>> A.) unexpected Network failures due to mac changes
>>
>> B.) surprised users (does anybody depend on such behavour?)
>>
>> I vote for A.)
>>
>> - Dietmar
>>
> 
> You might think A is a better option, but option B is frowned upon.  I
> understand you desire your change the behavior to meet your needs, but
> Patrick's suggestion to add a module parameter to tweak this behavior
> based on a module option is probably better than simply changing the
> existing functionality to meet your needs.

I actually meant a brctl parameter, module parameters suck as
configuration interfaces. But I think the second option is
better, just disable this behaviour automatically when the
address is configured manually.
