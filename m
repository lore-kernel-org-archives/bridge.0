MIME-Version: 1.0
Sender: gorcunov@gmail.com
In-Reply-To: <de7adc5e0905112230r60254113t6b31d8114d141be@mail.gmail.com>
References: <20090511114639.440944109@openvz.org>
	<de7adc5e0905112230r60254113t6b31d8114d141be@mail.gmail.com>
Date: Tue, 12 May 2009 10:19:20 +0400
Message-ID: <aa79d98a0905112319k6bc19ebk60a6458165b8c0a1@mail.gmail.com>
From: Cyrill Gorcunov <gorcunov@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC 0/5] bridge - introduce via_phys_dev feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Daniel Robbins <drobbins@funtoo.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, xemul@openvz.org

On 5/12/09, Daniel Robbins <drobbins@funtoo.org> wrote:
> Note: I am not a bridge guru but I'm interested in understanding this
> new functionality better. What is the larger benefit of this feature?
> Does this make it possible to configure a bridge setup on a remote
> system without losing connectivity? I can't do many kinds of network
> changes remotely without risking losing connectivity (ie. changing IP
> address, messing with routing, etc. -- it would be likely that you'd
> lose network connectivity :) ) Therefore, I don't know if this is a
> benefit unless it is needed for a particular application. Is this
> useful for OpenVZ in some way?
>
> Regards,
>
> Daniel
>
Hi Daniel,

The idea was exactly you described, ie have an ability to configure
remote system as bridge. There was an example how to use it in the
pach (last patch in series). Say we have remote system with eth0 set
up and running. So we may sign in into this system remotely. If we
have to confugure bridge on such a system (that even eth0 has to be
the bridge port) we connect to this system via eth0 then add bridge
br0 and run it via ifconfig br0 up, turn on via_phys_dev feature and
evetually add eth0 as a bridge port. We will have small delay in
session until port get forwarding state but after we could continue
work remotely on the system without reconfiguring routing table. Even
ssh session being used during configuration will continue operate. So
except a delay no session interrupt. I hope, need a good testing ;)

> On Mon, May 11, 2009 at 5:46 AM, Cyrill Gorcunov <gorcunov@openvz.org>
> wrote:
>> Hi,
>>
>> here is RFC for new via_phys_dev bridge feature.
>> In short -- it allows to use some bridge port as
>> bridge itself with already configured routing table.
>>
>> More details with example you may found in patches.
>>
>> Please review. Any (including _complains_) comments are
>> highly appreciated!
>>
>> The series is on top of current -net-next-2.6
>>
>>        | commit ed9b58bc443a1210b5be1ded6421b17e015bf985
>>        | Author Richard Genoud <richard.genoud@gmail.com>
>>        | Date Sat May 9 06:59:16 2009 +0000
>>
>> Cyrill
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>>
>
