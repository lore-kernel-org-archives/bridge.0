Return-Path: <vyasevic@redhat.com>
Message-ID: <513A0109.4040607@redhat.com>
Date: Fri, 08 Mar 2013 10:17:29 -0500
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1362691728-13289-1-git-send-email-vyasevic@redhat.com>
	<20130307214304.25e7784e@nehalam.linuxnetplumber.net>
In-Reply-To: <20130307214304.25e7784e@nehalam.linuxnetplumber.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH v2 net-next 0/3] Allow bridge to function
 in non-promisc mode
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 03/08/2013 12:43 AM, Stephen Hemminger wrote:
> On Thu,  7 Mar 2013 16:28:45 -0500
> Vlad Yasevich <vyasevic@redhat.com> wrote:
>
>> The series adds an ability to configure the bridge into a non-primiscuous
>> mode.   Instead, it provides the ability to identitfy some set of bridge
>> ports as uplinks and allows for MAC addresses to be programmed onto
>> those ports.  In case the port hardware does not support mac filter,
>> that port will be placed in promiscuous mode.
>>
>> Default bridge operation continues to remain as "promiscuous".  The new
>> functionality has to be enabled via sysfs (similar to other bridge extensions).
>>
>> The uplink mode is implemented as a flag on a bridge port.  The api to
>> change that flag follows the existing api to enable/disable other existing
>> flags.
>>
>> All comments are welcome.
>>
>
> Can we make this a one step process and less visible to the user.
> If user defines an uplink device, and the uplink device is capable of filtering
> (and what ever other pre-conditions people can think of), then the bridge will
> transparently switch to uplink/non-promisc mode.  This can also be used to trigger
> edge only mode in RSTP in the future.
>
> Less knobs.
>

Ok.  Let me see what I can do.

Thanks
-vlad

