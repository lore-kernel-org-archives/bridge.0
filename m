From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] Bridge and PACKET-socket
Date: Tue, 13 Jan 2004 20:35:26 +0100
References: <lhznd2do0m.fsf@dodo.bluetail.com>
	<200401122247.11045.bdschuym@pandora.be>
	<lhwu7wyful.fsf@dodo.bluetail.com>
In-Reply-To: <lhwu7wyful.fsf@dodo.bluetail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401132035.26330.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Luke Gorrie <luke@member.fsf.org>
Cc: bridge@osdl.org, Jason Lunz <lunz@falooley.org>

On Monday 12 January 2004 23:14, Luke Gorrie wrote:
> I agree that dev.c is not confusing, but the PACKET(7) interface
> is. If you bind to ETH_P_ALL you will receive every packet, but if you
> bind to any other protocol you will only receive packets the bridge
> doesn't take. The manpage doesn't say anything about this, and one
> might actually want different semantics (as in my case). IMO it would
> be nicer to have an interface that treats "what protocol do I want to
> see" and "do I want bridged packets" as orthogonal.

Reading the man page is indeed confusing for a user, w.r.t. bridge ports.
I think it would be more logical if all PF_PACKETsockets see the frames before 
the bridge code.
How about placing the call to __handle_bridge() right after the second 
list_for_each? If I'm not mistaken the relevant pt_pre->func that would deal 
with the packet will not have been executed yet, while those PF_PACKET 
functions will already have been called...

If you want the opinion of someone more knowledgeable than my humble self, the 
network guru's are located at netdev@oss.sgi.com.

cheers,
Bart

