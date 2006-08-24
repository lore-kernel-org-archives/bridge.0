Message-ID: <44EE2B45.6090301@kingsley.co.za>
Date: Fri, 25 Aug 2006 00:42:13 +0200
From: Etienne Pretorius <etiennep@kingsley.co.za>
MIME-Version: 1.0
References: <44EDE259.4050009@dotr.com> <m3u041yjlk.fsf@ursa.amorsen.dk>
In-Reply-To: <m3u041yjlk.fsf@ursa.amorsen.dk>
Content-Type: multipart/alternative;
	boundary="------------050503000004030002010206"
Subject: Re: [Bridge] transparent bridge and proxies
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

This is a multi-part message in MIME format...

--------------050503000004030002010206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am also all ears,

The transparent proxy without an IP address was my first attempt - but 
then I succumbed to the pressures of a due date and just eventually 
assigned an IP address to the bridged interfaces.
I suspect that it will have to be done with ip route 2 package - but 
even the one-way NAT does not make your machine transparent as you need 
to reply to ARP requests to allow the returning packet to find your 
machine/application....

PS, could this list please add a reply-to field to just allow me to 
reply to the list and not to the poster.... (so sorry Benny Amorsen for 
the other email).

Kind Regards
Etienne

Benny Amorsen wrote:
>>>>>> "JL-S" == Julian Lyndon-Smith <asterisk@dotr.com> writes:
>>>>>>             
>
> JL-S> So, I changed the ip address to 0.0.0.0. Everything except squid
> JL-S> still worked. I presume that's because it does not know how to
> JL-S> route the data to get stuff.
>
> JL-S> Can I add a rule to iptables or something to say "anything
> JL-S> that's come from eth1 into the local box, after processing send
> JL-S> to eth0" and vice-versa ?
>
> How about using 127.0.0.1 or something else on the local subnet?
> iptables should be able to redirect to that.
>
> I don't know how you'll get traffic from squid out of the box though.
> If you know a way to make squid reuse the original clients address in
> the outgoing connection, I'm all ears.
>
>
> /Benny
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
>   

--------------050503000004030002010206
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
I am also all ears,<br>
<br>
The transparent proxy without an IP address was my first attempt - but
then I succumbed to the pressures of a due date and just eventually
assigned an IP address to the bridged interfaces.<br>
I suspect that it will have to be done with ip route 2 package - but
even the one-way NAT does not make your machine transparent as you need
to reply to ARP requests to allow the returning packet to find your
machine/application.... <br>
<br>
PS, could this list please add a reply-to field to just allow me to
reply to the list and not to the poster.... (so sorry Benny Amorsen for
the other email).
<pre class="moz-signature" DEFANGED_cols="72">Kind Regards
Etienne
</pre>
Benny Amorsen wrote:
<blockquote cite="midm3u041yjlk.fsf@ursa.amorsen.dk" type="cite">
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="">"JL-S" == Julian Lyndon-Smith <a class="moz-txt-link-rfc2396E" href="mailto:asterisk@dotr.com">&lt;asterisk@dotr.com&gt;</a> writes:
            </pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
JL-S&gt; So, I changed the ip address to 0.0.0.0. Everything except squid
JL-S&gt; still worked. I presume that's because it does not know how to
JL-S&gt; route the data to get stuff.

JL-S&gt; Can I add a rule to iptables or something to say "anything
JL-S&gt; that's come from eth1 into the local box, after processing send
JL-S&gt; to eth0" and vice-versa ?

How about using 127.0.0.1 or something else on the local subnet?
iptables should be able to redirect to that.

I don't know how you'll get traffic from squid out of the box though.
If you know a way to make squid reuse the original clients address in
the outgoing connection, I'm all ears.


/Benny


_______________________________________________
Bridge mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bridge@lists.osdl.org">Bridge@lists.osdl.org</a>
<a class="moz-txt-link-freetext" href="https://lists.osdl.org/mailman/listinfo/bridge">https://lists.osdl.org/mailman/listinfo/bridge</a>
  </pre>
</blockquote>
</body>
</html>

--------------050503000004030002010206--
