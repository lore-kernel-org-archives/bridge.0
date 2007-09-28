DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
	bh=EYr1LxHpC8M2Q+eTruTgsTuV6oCHsAYCaxprxRUxhX8=;
	b=Vg0d3+J9zAKJTkZbhUB0562QkkNNnGd/8A5S/A9C/TOWUuvENlBZ1qDa0gPHjiSOhN2KHN8mUt3/0mphDPHstVSgJ9K4SAkKWi2C4JaZmx3pchkAEUpDpSKng9AaRMPJLlcvbXCyYE4yNcUh2JvtmNqCaJHey5/Kgdjh9paOkc4=
Message-ID: <2e59e6970709281151v69915609qf221bb5052fdd6a6@mail.gmail.com>
Date: Fri, 28 Sep 2007 13:51:42 -0500
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Subject: Re: [Bridge] Flushing MAC-tables(?)
In-Reply-To: <20070928134115.z8bvj5ws0oc00k0g@webapps>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3092_32252335.1191005502767"
References: <46FCB3F4.4080802@googlemail.com>
	<2e59e6970709281007g7cc3dd95gddca21e540ea886a@mail.gmail.com>
	<20070928134115.z8bvj5ws0oc00k0g@webapps>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Mark S. Mathews" <mark@linux-wlan.com>
Cc: bridge@lists.linux-foundation.org

------=_Part_3092_32252335.1191005502767
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 9/28/07, Mark S. Mathews <mark@linux-wlan.com> wrote:
>
> Good catch Richard, I forgot about the stale association problem.
>
> Actually, my note about having the 'new AP' wlan stack generate a
> bcast frame in reponse to the association event should take care of
> this problem as well.  When the old AP's wlan stack sees a frame
> coming in from above (i.e. off the wire) with a source address equal
> to one of its associated stations, it _should_ immediately disassoc
> that station thus breaking the mac-level STA-to-STA frame path.
>
> I think this 'send a bcast to the wire upon assoc' behavior is listed
> in a recommended-practices somewhere (been a long time).  It's
> basically a trick to enforce the 'STA shall be associated to
> one-and-only-one BSS within an ESS' rule.


Most stations will send a broadcast upon association even without help from
the AP (DHCP-REQUEST for example).

In this case, the station that moved can still hear the other station, which
makes me believe there is not a stale association, or stale MAC entries,
because the stationary node obviously found the new location of the mobile
node correctly.  It's the mobile node that can't transmit.  That's backwards
from the breakage you'd get from a stale association/stale bridge learn
table.


-Mark
>

------=_Part_3092_32252335.1191005502767
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 9/28/07, <b class="gmail_sendername">Mark S. Mathews</b> &lt;<a href="mailto:mark@linux-wlan.com">mark@linux-wlan.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Good catch Richard, I forgot about the stale association problem.<br><br>Actually, my note about having the &#39;new AP&#39; wlan stack generate a<br>bcast frame in reponse to the association event should take care of<br>
this problem as well.&nbsp;&nbsp;When the old AP&#39;s wlan stack sees a frame<br>coming in from above (i.e. off the wire) with a source address equal<br>to one of its associated stations, it _should_ immediately disassoc<br>that station thus breaking the mac-level STA-to-STA frame path.
<br><br>I think this &#39;send a bcast to the wire upon assoc&#39; behavior is listed<br>in a recommended-practices somewhere (been a long time).&nbsp;&nbsp;It&#39;s<br>basically a trick to enforce the &#39;STA shall be associated to
<br>one-and-only-one BSS within an ESS&#39; rule.</blockquote><div><br>Most stations will send a broadcast upon association even without help from the AP (DHCP-REQUEST for example).<br><br>In this case, the station that moved can still hear the other station, which makes me believe there is not a stale association, or stale MAC entries, because the stationary node obviously found the new location of the mobile node correctly.&nbsp; It&#39;s the mobile node that can&#39;t transmit.&nbsp; That&#39;s backwards from the breakage you&#39;d get from a stale association/stale bridge learn table.
<br><br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">-Mark<br></blockquote></div><br>

------=_Part_3092_32252335.1191005502767--
