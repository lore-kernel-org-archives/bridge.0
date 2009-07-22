References: <4A6638A5.208@ipfire.org>
	<2e59e6970907211559t1bf1c776r8684d59e98f96069@mail.gmail.com>
From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Wed, 22 Jul 2009 10:55:34 +0200
In-Reply-To: <2e59e6970907211559t1bf1c776r8684d59e98f96069@mail.gmail.com>
	(richardvoigt@gmail.com's message of "Tue\,
	21 Jul 2009 17\:59\:48 -0500")
Message-ID: <m3bpnddrll.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] Bridging untagged and tagged VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org, Michael Tremer <michael.tremer@ipfire.org>

Oh, and:

"richardvoigt@gmail.com" <richardvoigt@gmail.com> writes:

> There'd be problems with nested VLANs though.  In a system
> with two layer nesting, is a packet that arrives with only one tag
> treated as missing the inner tag or the outer one?

Inner tag missing. So eth0.0.30 would not ever receive any traffic (or
be able to send it in a RFC-conformant way), whereas eth0.30.0 would be
fine.


/Benny
