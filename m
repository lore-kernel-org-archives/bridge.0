Return-Path: <aenertia@aenertia.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aenertia.net; s=dkimaenertianet;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=V8XeirmmIkXQKKGfBtYv9DdTo4ET2QKzR3l4bMhpIY0=;
	b=KVdBFUHhZExqt1p12hCq5ZoFzOq4ZwyrqKvvy8qiEmtlrBggxhalu3ZtgyQeQMpfOf
	c1KX6avv045MoozSLCQHMDYbg2rGHpA7MAwrEYzN8RICkEGn0/1yYiW2HMYDzXEt/UKa
	iHIVR9MbuHX3VIaBAajfxgX9VtFitZUOmIFQw=
MIME-Version: 1.0
Sender: aenertia@aenertia.net
In-Reply-To: <5140B1B3.2070205@redhat.com>
References: <1363139126-13396-1-git-send-email-vyasevic@redhat.com>
	<473541363155743@web2d.yandex.ru> <51406D2D.30703@redhat.com>
	<20130313083932.6483876f@nehalam.linuxnetplumber.net>
	<51409F24.3070305@redhat.com>
	<20130313090921.05dbf6e2@nehalam.linuxnetplumber.net>
	<5140B1B3.2070205@redhat.com>
From: =?UTF-8?Q?Joel_Wir=C4=81mu_Pauling?= <joel@aenertia.net>
Date: Thu, 14 Mar 2013 07:56:49 +1300
Message-ID: <CAKiAkGRo0cHT6dJz5esih2hb2=Rxk27KG2dWBLr3wD=frEWveA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH net-next 0/4] Allow bridge to function in
 non-promisc mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vyasevic@redhat.com
Cc: Stephen Hemminger <stephen@networkplumber.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "Oleg A. Arkhangelsky" <sysoleg@yandex.ru>

I agree that this is a useful behavior, often we will use a bridge in
the same scenario (multiple virtio tap adapters belonging to VM's)
another scenario is when creating a bridge for chaining multiple VPN's
together.

-Joel

On 14 March 2013 06:04, Vlad Yasevich <vyasevic@redhat.com> wrote:
> On 03/13/2013 12:09 PM, Stephen Hemminger wrote:
>>
>> On Wed, 13 Mar 2013 11:45:40 -0400
>> Vlad Yasevich <vyasevic@redhat.com> wrote:
>>
>>> On 03/13/2013 11:39 AM, Stephen Hemminger wrote:
>>>>
>>>> On Wed, 13 Mar 2013 08:12:29 -0400
>>>> Vlad Yasevich <vyasevic@redhat.com> wrote:
>>>>
>>>>> On 03/13/2013 02:22 AM, "Oleg A. Arkhangelsky" wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> 13.03.2013, 05:45, "Vlad Yasevich" <vyasevic@redhat.com>:
>>>>>>
>>>>>>> The series adds an ability for the bridge to function in
>>>>>>> non-promiscuous mode.
>>>>>>
>>>>>>
>>>>>> What is the practical applications for such setup? In other words,
>>>>>> in which cases I would want to put bridge into non-promiscuous
>>>>>> mode and specify some uplink ports?
>>>>>>
>>>>>
>>>>> On of the applications would be when bridge is an edge device servicing
>>>>> a VM deployment.  Each of the VMs knows the mac address that the guest
>>>>> has and may program that mac onto the uplinks.
>>>>
>>>>
>>>> Why wouldn't that environment just use macvlan?
>>>> Is it because changing libvirt is harder than changing the kernel?
>>>>
>>>
>>> No, because macvlan has a drawback that it doesn't easily let guests
>>> talk to the host.  Bridge is still most commonly used for just that
>>> reason.
>>>
>>> -vlad
>>
>>
>> Maybe fixing that with a flag to macvlan would be easier?
>>
>
> Not really.  macvlan to physical device could be made simple enough.
> However, physical to macvlan is non-trivial at all.
>
> We get around this right now by crating a macvlan on the host and
> have macvlan to macvlan communication essentially turning it into
> bridge.  But that doesn't work in all scenarios either.
>
> -vlad
