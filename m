MIME-Version: 1.0
Sender: baringforge@gmail.com
In-Reply-To: <20101018203358.25775937@nehalam>
References: <AANLkTikRJVdCG=HD45cgjkFzK6H3i+WPyKMHz28+mXSb@mail.gmail.com>
	<20101018203358.25775937@nehalam>
From: Thomas Taranowski <tom@baringforge.com>
Date: Tue, 19 Oct 2010 12:55:03 -0700
Message-ID: <AANLkTinpj0onPiPP7xA3k_=A+TnUyhrrTrTmT1uc-sK=@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Giving enslaved interface an IP?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

Thanks Stephen, ebtables looks like what I eventually need.  I was
able to resolve my short term problem by aliasing br0, and giving it a
192.168.10.1/24 address, so it receives traffic on both subnets.  That
seems to resolve the issue nicely.


Thomas Taranowski
Certified netburner consultant
baringforge.com



On Mon, Oct 18, 2010 at 8:33 PM, Stephen Hemminger
<shemminger@linux-foundation.org> wrote:
> On Mon, 18 Oct 2010 19:16:18 -0700
> Thomas Taranowski <tom@baringforge.com> wrote:
>
>> I have bridged eth0 and eth1, where eth0 is the world, and eth1 has
>> some locally administered targets with normal IPs. =A0On eth1, I also
>> have some other devices with 192.168.x.x addresses I locally assigned.
>> =A0I'd like to give my eth1 a 192.168.x.x address, and treat the
>> 192.168.x.x network as something like a local network, where anything
>> else get's bridged across to eth0. =A0I'm running into some problems.
>>
>> First, when I try to ping anything on the 192.168.x.x network, it
>> get's sent out the wrong interface ( eth0 ), rather than eth1. =A0I
>> expected the bridge to broadcast the arp request to both interfaces.
>>
>> Second, giving eth1 an ip address, in addition to being bridged, had
>> no obvious effect. =A0Can I even do this?
>>
>> Any suggestions on where to look for additional information on this,
>> or things to try?
>
> Don't put IP address on only one interface unless you are
> setting up a brouter[1]. If you want to do firewalling then
> add ebtables rules to block traffic; doing firewalling
> with addressing won't work because the address won't be accessible
> as you found out.
>
>
> 1. A brouter requires additional ebtables to make packets flow.
>
