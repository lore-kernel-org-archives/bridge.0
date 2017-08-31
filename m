Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=RMrOS/ZO0N0OoKR8Qz17GYotLnBBVP6YbfyxDJOltrs=;
	b=rlbSKBA8uR0sMG1N/K9yr+++uuGR/bzk3pq7Gk9RFJ/fktttSKdj6qBMyyhb/K4riA
	nhHpa+Zdt2qW3hQPJTrcM7Qkf5zuVYKcDrQUw8lIr1haqNHIC0TkoHIt8r6Q1L3Cr6yq
	vGrnrgnfU3xnm5q7KcsCklCCNVzQPkPNEqJJRVdcRfFFLOgk4zmcyqf9KIIzkorkoq1j
	kialA+uMqmUYXLKBBKzDohsXtLVNW1tN4azSF55uFKtlvdIMbNz/EtYG9DdyRQBYHIn0
	+hb0EpGiOtkxFisklm1wFigqiREamd6wVs2V2rD3pwXYv4YxZAmQq/kPc0Qf6zyMDSbv
	8qQA==
Date: Thu, 31 Aug 2017 15:43:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170831154344.0a1f714e@xeon-e3>
In-Reply-To: <20170831235026.6377bf86@redhat.com>
References: <1504156693-24692-1-git-send-email-roopa@cumulusnetworks.com>
	<20170831.114325.2027598728601121750.davem@davemloft.net>
	<20170831235026.6377bf86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: add tracepoint in
	br_fdb_update
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

On Thu, 31 Aug 2017 23:50:26 +0200
Jesper Dangaard Brouer <brouer@redhat.com> wrote:

> On Thu, 31 Aug 2017 11:43:25 -0700 (PDT)
> David Miller <davem@davemloft.net> wrote:
> 
> > From: Roopa Prabhu <roopa@cumulusnetworks.com>
> > Date: Wed, 30 Aug 2017 22:18:13 -0700
> >   
> > > From: Roopa Prabhu <roopa@cumulusnetworks.com>
> > > 
> > > This extends bridge fdb table tracepoints to also cover
> > > learned fdb entries in the br_fdb_update path. Note that
> > > unlike other tracepoints I have moved this to when the fdb
> > > is modified because this is in the datapath and can generate
> > > a lot of noise in the trace output. br_fdb_update is also called
> > > from added_by_user context in the NTF_USE case which is already
> > > traced ..hence the !added_by_user check.
> > > 
> > > Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>    
> > 
> > Applied.
> > 
> > Let's use dev->name for now and if the tooling can eventually
> > do transparent ifindex->name then we can consider redoing
> > a bunch of networking tracepoints.  
> 
> I agree! :-)
> 

Agreed, but it is yet another case of tracepoints not having
a stable ABI. There is no ABI guarantee on tracing, but it still
makes for user complaints.
