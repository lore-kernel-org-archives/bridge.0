Return-Path: <stephen@networkplumber.org>
Date: Tue, 25 Nov 2014 20:30:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20141125203057.3bdc2da9@urahara>
In-Reply-To: <CAHD0KLk1PGUbSB+e8LQF7cj3rqUZ_E2hNa2otvRWcQ6-xOn=ug@mail.gmail.com>
References: <CAHD0KLkXTH5fOMuxc7r6RQQ5f6J4vEOiGqjj1NsOSANq0=p0ZQ@mail.gmail.com>
	<20141125151308.3ede216c@urahara>
	<CAHD0KLk1PGUbSB+e8LQF7cj3rqUZ_E2hNa2otvRWcQ6-xOn=ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge Consuming LACP PDUs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jogesh panda <jogesh.panda@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 25 Nov 2014 17:07:12 -0800
jogesh panda <jogesh.panda@gmail.com> wrote:

> Hello
> 
> Thanks for the reply. This still does not solve my problem for forwarding
> LACP PDU (  01-80-C2-00-00-02 ).

LACP PDU's are not supposed to be forwarded.
I had some discussion with 802 committee about it.

