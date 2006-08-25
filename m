Message-ID: <8cbd14710608250346g2147f993h248488f7d52a8b6b@mail.gmail.com>
Date: Fri, 25 Aug 2006 06:46:04 -0400
From: Skept <impossibleprobability@gmail.com>
In-Reply-To: <mailman.3.1156446009.32505.bridge@lists.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <mailman.3.1156446009.32505.bridge@lists.osdl.org>
Subject: Re: [Bridge] Bridge Digest, Vol 36, Issue 8
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Julian,

I did not understand what you meant by this paragraph.

"Now, for the twist. For development and testing, I assigned an ip
address and gateway to the bridge. I need to be able for a "non-it"
person to install this box without having to set it up at all , so it
cannot have an ip address assigned, as it *may* be in use somewhere else
on the lan or router."

Did your bridge + transparent proxy work without you adding an ip[\and
route] to the bridge interface? I mean, before the "twist".

Skept

On 8/24/06, bridge-request@lists.osdl.org <bridge-request@lists.osdl.org> wrote:
> Send Bridge mailing list submissions to
> 	bridge@lists.osdl.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://lists.osdl.org/mailman/listinfo/bridge
> or, via email, send a message with subject or body 'help' to
> 	bridge-request@lists.osdl.org
>
> You can reach the person managing the list at
> 	bridge-owner@lists.osdl.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Bridge digest..."
>
>
> Today's Topics:
>
>    1. transparent bridge and proxies (Julian Lyndon-Smith)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Thu, 24 Aug 2006 18:31:05 +0100
> From: Julian Lyndon-Smith <asterisk@dotr.com>
> Subject: [Bridge] transparent bridge and proxies
> To: bridge@lists.osdl.org
> Message-ID: <44EDE259.4050009@dotr.com>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> I want to be able to install a box that is a transparent bridge, but
> that is also running a transparent proxy, but with a twist ..
>
> i am a newbie in all things linux, so bear with me :)
>
> So far I have managed to install centos 4.3, and following various
> guides on the net, created a bridge between eth1 (connected to lan) and
> eth0 (connected to router). That works great.
>
> I also managed to install squid, get it running transparently and added
> a rule to iptables to make all that work just fine. So now, all my
> clients attached to the lan run through the squid proxy without them
> knowing.
>
> Now, for the twist. For development and testing, I assigned an ip
> address and gateway to the bridge. I need to be able for a "non-it"
> person to install this box without having to set it up at all , so it
> cannot have an ip address assigned, as it *may* be in use somewhere else
> on the lan or router.
>
> So, I changed the ip address to 0.0.0.0. Everything except squid still
> worked. I presume that's because it does not know how to route the data
> to get stuff.
>
> Can I add a rule to iptables or something to say "anything that's come
> from eth1 into the local box, after processing send to eth0" and
> vice-versa ?
>
> Julian.
>
>
> ------------------------------
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
>
>
> End of Bridge Digest, Vol 36, Issue 8
> *************************************
>
