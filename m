Return-Path: <mcgrof@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=J0bN0LDR5wDRHh4JU0h18dwlUr+BFs3qP86fg5KpbXw=;
	b=CDZp7eLlaUKid7J//kzBYaFZveX/hMiA9wnUEgRq+RtTeRDqmHPXPDc+r5tx4Q+6jE
	d8xZhapkzcD8ez4pc+zNJlfAaEvoOBVJ2ZmBGQdNlxYpWN2DkY3dj2J/c+nDlEhqY+qX
	sPb6uS86rbN/0VHm7ZpFXwX1/92Gsi8+oSfMClvFlV/loInWLlzkrNn9Z4oBozFEkmRz
	YUv2+sbPLIxEje1jQwmge1uri1d7tr2ynPSLPwvr+sqQM7F8wPPEb5JsgonFE2aSySw+
	dV5O0U3/4gCRN3VPkbxGxyX52wV16Eh+Pj6j16kPaJVM5xpd5QCzFws9cgADprqeTClB
	tgsA==
MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <5328ED25.1040900@lab.ntt.co.jp>
References: <1394680527-28970-1-git-send-email-mcgrof@do-not-panic.com>
	<1394680527-28970-2-git-send-email-mcgrof@do-not-panic.com>
	<5328E802.3030901@lab.ntt.co.jp>
	<CAB=NE6X2eZFLWBN1acf=d75T_K2YM_OK3oaXEPu-hwpUJEmwkg@mail.gmail.com>
	<5328ED25.1040900@lab.ntt.co.jp>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 18 Mar 2014 18:10:05 -0700
Message-ID: <CAB=NE6VL8LCGa5aqm8qpgwHywwvVb8gjNQFKic_Dq9zdg-8hDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH 1/3] bridge: preserve random init MAC address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: kvm@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, xen-devel@lists.xenproject.org

On Tue, Mar 18, 2014 at 6:04 PM, Toshiaki Makita
<makita.toshiaki@lab.ntt.co.jp> wrote:
> (2014/03/19 9:50), Luis R. Rodriguez wrote:
>> On Tue, Mar 18, 2014 at 5:42 PM, Toshiaki Makita
>> <makita.toshiaki@lab.ntt.co.jp> wrote:
>>> nit,
>>> If the last detached port happens to have the same addr as
>>> random_init_addr, this seems to call br_stp_change_bridge_id() even
>>> though bridge_id is not changed.
>>
>> Ah good point.
>>
>>> Shouldn't the assignment of random_init_addr be done before the check of
>>> "no change"?
>>
>> Good question, should we even allow two ports to have the same MAC
>> address or should we complain and refuse to add it? If so that should
>> mean we should also have to monitor any manual address changes or
>> events for address changes on the ports.
>
> This was recently discussed by Stephen and me.
> I'm thinking it should be allowed.
>
> http://marc.info/?l=linux-netdev&m=139182743919257&w=2

Great now that that's sorted out though I still think calling
br_stp_change_bridge_id() is right just as calling the update features
as the device is different. It could however be confusing when this
situation is run and folks might report odd bugs unless we could tell
them apart clearly. Thoughts?

  Luis
