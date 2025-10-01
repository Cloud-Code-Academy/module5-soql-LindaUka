/**
 * The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
 * It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
 *
 * This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
 * a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
 * records, and manage data volume using the LIMIT keyword.
 *
 * Topics covered in this class include:
 * - Understanding the structure of a SOQL query.
 * - Crafting basic SELECT statements in SOQL.
 * - Applying filters using the WHERE clause in SOQL.
 * - Fetching related records using Relationship queries.
 * - Controlling the amount of data retrieved using the LIMIT keyword.
 *
 * Users of this class can expect to gain a solid understanding of SOQL in Apex and
 * be prepared to handle data retrieval tasks in Salesforce development.
 *
 * @author Your Name
 */

public with sharing class SOQL {
	/**
	 * Question 1
	 * Update/Uncomment the template code to create a method
	 * Returns all leads from Salesforce Org
	 * @return List of all leads with Id, LastName, Company, Phone, Email
	 * Update the corresponding test class and testGetAllLeads method to cover this method
	 */
	public static List<Lead> getAllLeads() {
        return [SELECT Id, LastName, Company, Phone, Email FROM Lead];
    }

	/**
	 * Question 2
	 * Update/Uncomment the template code to create a method
	 * Returns all contacts with first name of John.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByFirstName method to cover this method
	 */
	public static List<Contact> getContactsByFirstName () {
		return [SELECT Id, Name, FirstName, LastName FROM Contact WHERE FirstName = 'John'];
	}

	/**
	 * Question 3
	 * Update/Uncomment the template code to create a method
	 * Returns the Contact Id for all contacts with last name of Smith or Jones
	 * @return A list of Contact Ids.
	 * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
	 */
	public static List<Contact> getContactsByLastName () {
		return [SELECT Id, FirstName, LastName FROM Contact WHERE LastName = 'Smith' OR LastName = 'Jones'];
		
		
	}
	

	/**
	 * Question 4
	 * Update/Uncomment the template code to create a method
	 * Returns List of closed won opportunities for a specific Account.
	 * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Opportunities with important opportunities fields
	 * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
	 */
	public static List<Opportunity> getClosedWonOpportunityCountByAccount(Id accountId) {
		 List<Opportunity> opps = [SELECT Id, AccountId, Amount, Name, StageName, CloseDate FROM Opportunity WHERE AccountId = :accountId AND StageName = 'Closed Won'];
		 return opps;
	}

	/**
	 * Question 5
	 * Update/Uncomment the template code to create a method
	 * Returns the total count of Account records.
	 * @return The Integer count of Account records.
	 * Update the corresponding test class and testGetAccountCount method to cover this method
	 */
	public static Integer getAccountCount () {
		return [SELECT COUNT() FROM Account];
	}

	/**
	 * Question 6
	 * Update/Uncomment the template code to create a method
	 * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
	 * @return A map of Task Ids to Task records.
	 * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
	 */
	public static Map< Id, Task> getTasksDueNextWeek () {
		 Map<Id, Task> taskMap = new Map<Id, Task>();
		 List<Task> tasks = [SELECT Id, Subject, ActivityDate FROM Task WHERE ActivityDate = NEXT_N_DAYS:7];
		 for (Task t : tasks) {
			 taskMap.put(t.Id, t);
		 }
		 return taskMap;
	}
	
	/**
	 * Question 7
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Contacts that have a example.com domain in their Email.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
	 */
	public static List<Contact> getContactsByEmailDomain () {
		return [SELECT Id, Name, FirstName, LastName, Email FROM Contact WHERE Email LIKE '%example.com'];
	}

	/**
	 * Question 8
	 * Retrieves all Opportunities that have a specific keyword in their Name.
	 * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
	 * @param keyword The keyword to search for in the Opportunity Name.
	 * @return A list of Opportunity records.
	 */
	public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
		String likePattern = '%' + keyword + '%';

		List<Opportunity> opps = [SELECT Id, Name, Amount, StageName, CloseDate FROM Opportunity WHERE Name LIKE :likePattern];
		return opps;
		
	}

	/**
	 * Question 9
	 * Retrieves all Cases that Case Origin is not Web or Email or Blank
	 * @return A list of Case records.
	 */
	public static List<Case> getFilterCaseOrigins() {
		return [SELECT Id, Subject, Status, Origin, Description FROM Case WHERE Origin NOT IN ('Web', 'Email') AND Origin != null];
		
	}

	/**
	 * Question 10
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
	 * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
	 * @param leadSource The Lead Source to search for.
	 * @param keyword The keyword to search for in the Lead Title.
	 * @return A list of Lead records.
	 * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
	 */
	public static List<Lead> getLeadsBySourceOrTitle (String leadSource, String keyword) {
		String Source = leadSource;
		String likePattern = '%' + keyword + '%';
		List<Lead> leads = [SELECT Id, Phone, Email, LastName, Company, Title, LeadSource FROM Lead WHERE LeadSource = :Source OR Title LIKE :likePattern];
		return leads;
	}

	
	/**
	 * Question 11
	 * Returns the names of all Contacts associated with an Account.
	 * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Contact LastName.
	 */
	public static List<String> getContactNamesByAccount(Id accountId) {
		// Create a list to hold the Contact LastNames
		List <String> contactNames = new List<String>();
		List<Contact> contacts = [SELECT LastName FROM Contact WHERE AccountId = :accountId];
		for (Contact c : contacts) {
			contactNames.add(c.LastName);
		}
		return contactNames;
		
	}

	/**
	 * Question 12
	 * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
	 * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
	 * @param stage The Stage value to filter Opportunities.
	 * @return The total revenue.
	 */
	public static Decimal getTotalRevenueByStage(String stage) {
		Decimal totalRevenue = 0;

    AggregateResult[] results = [
        SELECT SUM(Amount) totalRevenue
        FROM Opportunity
        WHERE StageName = :stage OR Amount > 10000
    ];

    if (!results.isEmpty() && results[0].get('totalRevenue') != null) {
        totalRevenue = (Decimal) results[0].get('totalRevenue');
    }

    return totalRevenue;
}


	/**
	 * Question 13
	 * Retrieves the first 10 Accounts ordered by Name.
	 * @return A list of the first 10 Accounts ordered by Name.
	 */
	public static List<Account> getFirstTenAccounts() {
		List<Account> accounts = [SELECT Name FROM Account ORDER BY Name LIMIT 10];
		return accounts;
	
	}

	/**
	 * Question 14
	 * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 */
	public static List<Opportunity> getHighValueOpportunities() {
		List<Opportunity> opportunities = [SELECT Name, Amount, CloseDate FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate LIMIT 5];
		return opportunities;
	}

	/**
	 * Question 15
	 * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
	 * @return A list of Contacts
	 */
	public static List<Contact> getBirthdateContacts() {
		List<Contact> contacts = [SELECT Name, Birthdate FROM Contact ORDER BY Birthdate DESC LIMIT 3];
		return contacts;
		
	}

	/**
	 * Question 16
	 * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
	 * @return A list of Cases
	 */
	public static List<Case> getCasesWithStatus() {
		List<Case> cases = [SELECT Id, Status, CreatedDate FROM Case WHERE Status = 'Open' ORDER BY CreatedDate LIMIT 10 OFFSET 5];
		return cases;
		
	}

	/**
	 * Question 17
	 * Returns Set of Case Ids for a specific Account.
	 * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A set of Case Ids.
	 */
	public static Set<Id> getCaseIdsByAccount(Id accountId) {
		List<Case> cases = [SELECT Id FROM Case WHERE AccountId = :accountId];
		Set<Id> caseIds = new Set<Id>();
		for (Case c : cases) {
			caseIds.add(c.Id);
		}
		return caseIds;
	}

	/**
	 * Question 18
	 * Return Map of Account Ids to Account Names Not in a specific Country.
	 * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
	 * @param country The country to filter Accounts.
	 * @return A map of Account Ids to Account Names.
	 */
	public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
		// Create a map to hold the Account Ids to Account Names
		Map<Id, String> accountIdsToNames = new Map<Id, String>();

		// Query the Accounts
		List<Account> accounts = [SELECT Id, Name, BillingCountry FROM Account WHERE BillingCountry != :country];
		// Loop through each Account and add the Id and Name to the map
		for (Account a : accounts) {
			accountIdsToNames.put(a.Id, a.Name);
		}
		
		return accountIdsToNames;

	
	}

	/**
	 * Question 19
	 * Retrieves the Account Name for a given Contact.
	 * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
	 * @param contactId The Id of the Contact.
	 * @return The Account Name of the Contact.
	 */
	public static String getAccountNameForContact(String contactId) {
		List<Contact> contacts = [SELECT Account.Name FROM Contact WHERE Id = :contactId LIMIT 1];
		for (Contact c : contacts) {
			return c.Account.Name;
		}
		return null;
	}

	/**
	 * Question 20
	 * Returns single Account that has related opportunities in the same query
	 * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
	 * @param accountId The ID of the Account.
	 * @return An Account record with related Opportunities.
	 */
	public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
		List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Id = :accountId];
		for (Account a : accounts) {
			return a;
		}
		return null; 
	}

	/**
	 * Question 21
	 * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
	 * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
	 * @param Account Id
	 * @return List of contacts with the same Mailing State as the Account Billing State
	 */
	public static List<Contact> getAccountsWithContactsByState(Id accountId) {
    Account acc = [SELECT BillingState FROM Account WHERE Id = :accountId LIMIT 1];

    List<Contact> matchingContacts = [
        SELECT Id, FirstName, LastName, MailingState, AccountId
        FROM Contact
        WHERE MailingState = :acc.BillingState
    ];

    return matchingContacts;
}


	/**
	 * Question 22
	 * Extracts email domains from them leads, then finds Accounts with matching website domains
	 * If Lead Email = test@test.com return account with website = www.test.com
	 * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
	 * @param A set of Lead Ids.
	 * @return A list of Accounts with matching email domains.
	 */
	public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
    // Query the Leads
    List<Lead> leads = [SELECT Email FROM Lead WHERE Id IN :leadIds];

    // Create a set of email domains
    Set<String> emailDomains = new Set<String>();
    for (Lead l : leads) {
        if (l.Email != null && l.Email.contains('@')) {
            String domain = l.Email.substringAfter('@');
            emailDomains.add(domain.toLowerCase());
        }
    }

    // Build website patterns like www.test.com
    Set<String> websitePatterns = new Set<String>();
    for (String domain : emailDomains) {
        websitePatterns.add('www.' + domain);
    }

    // Query matching Accounts
    List<Account> matchingAccounts = [
        SELECT Id, Name, Website
        FROM Account
        WHERE Website IN :websitePatterns
    ];

    return matchingAccounts;
}


	/**
	 * Question 23
	 * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
	 * Adds a randomized number between 1 to 3 to the quantity of each line item.
	 * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
	 * @param Original Opportunity Id
	 * @param List of cloned Opportunity Ids
	 */
	public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
    // Query the original Opportunity Line Items
    List<OpportunityLineItem> originalLineItems = [
        SELECT PricebookEntryId, Quantity, UnitPrice, Description
        FROM OpportunityLineItem
        WHERE OpportunityId = :origOppId
    ];

    // Create a list to hold the new line items
    List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();

    // Loop through each cloned Opportunity Id
    for (Id cloneOppId : cloneOppIds) {
        // Loop through each original line item
        for (OpportunityLineItem oli : originalLineItems) {
            // Generate a random number between 1 and 3
            Integer randomBump = Math.mod(Crypto.getRandomInteger(), 3) + 1;

            // Clone the original line item and add the random number to the quantity
            OpportunityLineItem newItem = new OpportunityLineItem(
                OpportunityId = cloneOppId,
                PricebookEntryId = oli.PricebookEntryId,
                Quantity = oli.Quantity + randomBump,
                UnitPrice = oli.UnitPrice,
                Description = oli.Description
            );
            newLineItems.add(newItem);
        }
    }

    // Insert the new line items
    if (!newLineItems.isEmpty()) {
        insert newLineItems;
    }
}

	/**
	 * Question 24
	 * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
	 * @return A list of filtered Opportunity
	 */
	public static List<Opportunity> getOpportunityDetailsForClosedWon() {
		List<Opportunity> opportunities = [SELECT Id, Name, Account.Name, Owner.Name FROM Opportunity WHERE StageName = 'Closed Won'];
		
		if (!opportunities.isEmpty()) {
			return opportunities;
		}
		return null; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 25
	 * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to the Contact on the associated Account with the alphabetically first first name.
	 * Example: if there are two Contacts on the Account, "Billy" and "Abby," the 'Primary_Contact__c' will be set to "Abby."
	 */
	
	public static void setPrimaryContact() {
    // Get Closed Won Opportunities
    List<Opportunity> opportunities = getOpportunityDetailsForClosedWon();
    if (opportunities.isEmpty()) {
        return;
    }

    // Collect Account Ids
    Set<Id> accountIds = new Set<Id>();
    for (Opportunity o : opportunities) {
        if (o.AccountId != null) {
            accountIds.add(o.AccountId);
        }
    }

    // Query Contacts and group by AccountId
    Map<Id, List<Contact>> accountToContactsMap = new Map<Id, List<Contact>>();
    for (Contact c : [SELECT Id, AccountId, FirstName FROM Contact WHERE AccountId IN :accountIds]) {
        if (!accountToContactsMap.containsKey(c.AccountId)) {
            accountToContactsMap.put(c.AccountId, new List<Contact>());
        }
        accountToContactsMap.get(c.AccountId).add(c);
    }

    // Map AccountId to alphabetically first Contact
    Map<Id, Contact> accountToPrimaryContact = new Map<Id, Contact>();
    for (Id accId : accountToContactsMap.keySet()) {
        List<Contact> contacts = accountToContactsMap.get(accId);
		contacts.sort();
        accountToPrimaryContact.put(accId, contacts[0]);
    }

    // Update Opportunities
    for (Opportunity o : opportunities) {
        if (accountToPrimaryContact.containsKey(o.AccountId)) {
            o.Primary_Contact__c = accountToPrimaryContact.get(o.AccountId).Id;
        }
    }

    update opportunities;
}
}
