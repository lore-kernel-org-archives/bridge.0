Return-Path: <stephen@networkplumber.org>
Date: Sun, 29 Dec 2013 16:53:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20131229165330.14b1337f@nehalam.linuxnetplumber.net>
In-Reply-To: <20131228223732.GA30591@cumulusnetworks.com>
References: <20131228223732.GA30591@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/1] bridge/br_multicast: use spin_lock_bh() in
 br_multicast_set_hash_max()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Curt Brune <curt@cumulusnetworks.com>
Cc: bridge@lists.linux-foundation.org, Shrijeet Mukherjee <shm@cumulusnetworks.com>

On Sat, 28 Dec 2013 14:37:32 -0800
Curt Brune <curt@cumulusnetworks.com> wrote:

> br_multicast_set_hash_max() is called from process context in
> net/bridge/br_sysfs_br.c by the sysfs store_hash_max() function.
> 
> br_multicast_set_hash_max() calls spin_lock(&br->multicast_lock),
> which can deadlock the CPU if a softirq that also tries to take the
> same lock interrupts br_multicast_set_hash_max() while the lock is
> held .  This can happen quite easily when any of the bridge multicast
> timers expire, which try to take the same lock.

Running lockdep should catch these kind of things without having
to do stress tests.

