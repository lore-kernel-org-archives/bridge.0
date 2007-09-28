DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
	bh=Fw7Z7OEadOL45kg7TaHF1KlvVloJjGPrLMsTHpfyfEs=;
	b=V4QK2V7DVDarYObduDtV0VLg105vmN/YFuhN8JZtwnLKVaOub2MTjuNIt2VHp01Jm/l6qHqUTQvuGPQzw1k9Md07wyUMhuKf/LhZq2WLv4LYPW0Ri58hMHvDx7Fe/779+FvAF9oDAsTixlzNjd51hLUYoC4axBAU6fhQFxivVfk=
Message-ID: <2e59e6970709281007g7cc3dd95gddca21e540ea886a@mail.gmail.com>
Date: Fri, 28 Sep 2007 12:07:51 -0500
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Subject: Re: [Bridge] Flushing MAC-tables(?)
In-Reply-To: <46FCB3F4.4080802@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2704_26316194.1190999271282"
References: <46FCB3F4.4080802@googlemail.com>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dennis Borgmann <dennis.borgmann@googlemail.com>
Cc: bridge@lists.linux-foundation.org

------=_Part_2704_26316194.1190999271282
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 9/28/07, Dennis Borgmann <dennis.borgmann@googlemail.com> wrote:
>
> Dear list-members!
>
> I am using OpenWRT (www.openwrt.org) on two accesspoints. Within
> OpenWRT, the wireless interface and the ethernet interface are bridged
> to one interface (br0).
>
> Those two accesspoints are standing quite far from one another. Their
> WLAN-cells do not cross each other, meaning I have an area in between
> the two accesspoints, where there is no accesspoint of the two
> accessible: a dead spot.
>
> Now I use two WLAN-telephones (Cisco 7920). I start calling one of the
> phones inside the same radio cell and I answer this call. Now I start
> moving away to the other accesspoint. As soon as I see myself assiciated
> to the "new" accesspoint, I am able to hear my mate on the other phone
> in the "old" cell, but he cannot hear me. This stays this way, until a



This seems not to be a bridging problem then, since your pal didn't move to
a new access point, his information should be correct in all bridges (either
correct interface or no entry).  Therefore packets sent to him should be
correctly delivered.  OTOH his outgoing packets could be blocked by his
access point as long as it thinks you are locally attached (the first packet
coming in via the other access point should disillusion it without need for
a timer).

The behavior you are seeing is opposite, therefore I think you have
misidentified the cause.  Can you use VOIP software on a real computer, and
run packet capture software?  It might be very informative to have a
connection phone <-> computer and also computer <-> computer in order to see
if any packets are actually being missed, and in which direction.

Most likely your phone clears the routing table when you dissociate from the
other access point, and  the routing table isn't rebuilt until dhcp runs at
the new location.  This affects outgoing packets more than incoming, since
your adapter still may honor packets destined to your MAC address and
broadcast within its range.  Of course it may not be the routing table
either.


certain point of time is reached. In our tests, he has been able to hear
> my voice recurring at :30 each minute. Take these examples:
>
> 05:40:20 I roamed to the "new" AP
> 05:40:30 my mate could hear me
>
> 05:43:35 I roamed to the "new" AP
> 05:44:30 my mate could hear me
>
> 05:47:03 I roamed to the "new" AP
> 05:47:30 my mate could hear me
>
> ...and so on.
>
> So at a certain point of time, there seems to be a flushing of some
> bridge-tables, but I don't know, how I could influence this behaviour.
> Is this "flushing" somehow to be done manually? Or is there a timer,
> which sets this behaviour?
>
> I sniffed the WLAN a little while my tests have been done and the result
> is, that the "old" accesspoint seems to still believe me in his radio
> cell. So he sends out data for me all of the time, but since my
> telephone has moved away, there is no more client to ACK these packages.
> After the time mentioned before has passed, these packet are away and
> the communication goes on the way it should. So I assume, there is a
> timeout, that tells the AP to flush its old bridge-MAC tables of
> clients, that he did not hear of since XX seconds...
>
> Any help would be appreciated. Thanks a lot in advance,
>
> Dennis
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>

------=_Part_2704_26316194.1190999271282
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 9/28/07, <b class="gmail_sendername">Dennis Borgmann</b> &lt;<a href="mailto:dennis.borgmann@googlemail.com">dennis.borgmann@googlemail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dear list-members!<br><br>I am using OpenWRT (<a href="http://www.openwrt.org">www.openwrt.org</a>) on two accesspoints. Within<br>OpenWRT, the wireless interface and the ethernet interface are bridged<br>to one interface (br0).
<br><br>Those two accesspoints are standing quite far from one another. Their<br>WLAN-cells do not cross each other, meaning I have an area in between<br>the two accesspoints, where there is no accesspoint of the two<br>accessible: a dead spot.
<br><br>Now I use two WLAN-telephones (Cisco 7920). I start calling one of the<br>phones inside the same radio cell and I answer this call. Now I start<br>moving away to the other accesspoint. As soon as I see myself assiciated
<br>to the &quot;new&quot; accesspoint, I am able to hear my mate on the other phone<br>in the &quot;old&quot; cell, but he cannot hear me. This stays this way, until a</blockquote><div><br><br>This seems not to be a bridging problem then, since your pal didn&#39;t move to a new access point, his information should be correct in all bridges (either correct interface or no entry).&nbsp; Therefore packets sent to him should be correctly delivered.&nbsp; OTOH his outgoing packets could be blocked by his access point as long as it thinks you are locally attached (the first packet coming in via the other access point should disillusion it without need for a timer).
<br><br>The behavior you are seeing is opposite, therefore I think you have misidentified the cause.&nbsp; Can you use VOIP software on a real computer, and run packet capture software?&nbsp; It might be very informative to have a connection phone &lt;-&gt; computer and also computer &lt;-&gt; computer in order to see if any packets are actually being missed, and in which direction.
<br><br>Most likely your phone clears the routing table when you dissociate from the other access point, and&nbsp; the routing table isn&#39;t rebuilt until dhcp runs at the new location.&nbsp; This affects outgoing packets more than incoming, since your adapter still may honor packets destined to your MAC address and broadcast within its range.&nbsp; Of course it may not be the routing table either.
<br>&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">certain point of time is reached. In our tests, he has been able to hear<br>my voice recurring at :30 each minute. Take these examples:
<br><br>05:40:20 I roamed to the &quot;new&quot; AP<br>05:40:30 my mate could hear me<br><br>05:43:35 I roamed to the &quot;new&quot; AP<br>05:44:30 my mate could hear me<br><br>05:47:03 I roamed to the &quot;new&quot; AP
<br>05:47:30 my mate could hear me<br><br>...and so on.<br><br>So at a certain point of time, there seems to be a flushing of some<br>bridge-tables, but I don&#39;t know, how I could influence this behaviour.<br>Is this &quot;flushing&quot; somehow to be done manually? Or is there a timer,
<br>which sets this behaviour?<br><br>I sniffed the WLAN a little while my tests have been done and the result<br>is, that the &quot;old&quot; accesspoint seems to still believe me in his radio<br>cell. So he sends out data for me all of the time, but since my
<br>telephone has moved away, there is no more client to ACK these packages.<br>After the time mentioned before has passed, these packet are away and<br>the communication goes on the way it should. So I assume, there is a
<br>timeout, that tells the AP to flush its old bridge-MAC tables of<br>clients, that he did not hear of since XX seconds...<br><br>Any help would be appreciated. Thanks a lot in advance,<br><br>Dennis<br>_______________________________________________
<br>Bridge mailing list<br><a href="mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-foundation.org</a><br><a href="https://lists.linux-foundation.org/mailman/listinfo/bridge">https://lists.linux-foundation.org/mailman/listinfo/bridge
</a><br></blockquote></div><br>

------=_Part_2704_26316194.1190999271282--
