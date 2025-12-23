# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Chongqing Cultural Tourism Website (重庆市文旅网站) project consisting of:
- **Backend Management**: Admin panel built with RuoYi framework for rapid development
- **User Frontend**: Modern tourism website interface (separate from this repository)
- **AI Integration**: Planned SpringAI + MCP implementation for intelligent scenic spot recommendations

The system showcases Chongqing's cultural tourism resources including A-rated scenic spots, cultural venues, and特色活动, providing a comprehensive platform for both locals and tourists to discover and engage with the city's cultural offerings.

## Architecture

### Backend (Spring Boot + MyBatis + RuoYi Framework)
- **Multi-module Maven project** leveraging RuoYi framework for rapid admin development
- **cquet-admin**: Main application entry point with Spring Boot startup class
- **cquet-framework**: Core framework components (security, config, web) - extends RuoYi
- **cquet-system**: System management modules (user, role, menu, dict) - RuoYi base modules
- **cquet-tourism**: Tourism business logic modules (custom business domain)
- **cquet-common**: Common utilities and shared components
- **cquet-generator**: Code generation tools (RuoYi's code generator)

### Backend Admin Frontend (Vue 2 + Element UI)
- **cquet-ui-demo**: RuoYi-based admin panel interface
- Uses Element UI component library for consistent admin UI
- Employs Vue Router for navigation and Vuex for state management
- Includes axios for HTTP requests and echarts for admin data visualization

### User-Facing Frontend
- **Separate Repository**: Modern tourism website interface (not in this repo)
- Provides public-facing content for tourists and locals
- Showcases Chongqing's tourism attractions and activities

## Development Commands

### Backend (Maven)
```bash
# Navigate to project root
cd E:\工程代码\毕业设计\cquet-demo

# Clean and compile
mvn clean compile

# Run tests
mvn test

# Package application
mvn clean package

# Run the application (from cquet-admin directory)
cd cquet-admin
mvn spring-boot:run
```

### Frontend (npm/vue-cli)
```bash
# Navigate to frontend directory
cd cquet-ui-demo

# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build:prod

# Build for staging
npm run build:stage

# Run linting
npm run lint
```

## Business Domain

### Core Entities
The system manages three main types of tourism resources:

1. **A级景区 (Scenic Spots)**: Rated tourist attractions (A-AAAAA)
   - Natural landscapes or historical sites
   - May be free or paid entry
   - Examples: Hongya Cave (4A), Dazu Rock Carvings (5A)

2. **场馆 (Venues)**: Cultural, sports, and educational facilities
   - Museums, libraries, stadiums, theaters
   - Indoor venues with capacity limits
   - Examples: Chongqing Library, Chongqing Olympic Center

3. **特色活动 (Activities)**: Cultural and recreational events
   - Not ticket sales, but cultural experiences promoting local culture
   - Includes performances, workshops, festivals, educational activities
   - Examples: Sichuan Opera (川剧变脸), calligraphy classes, marathon races, traditional festivals

### Key Relationships
- **Venues → Activities**: Activities are hosted at specific venues
- **Users → Collections**: Users can favorite scenic spots, venues, activities
- **Users → Activity Applications**: Users apply for activity participation (requires approval)
- **Users → Activity Comments**: Users can comment on activities with reply support

## Database Schema

The system uses MySQL with the following key tables:
- `tourism_scenic_spot`: Scenic attraction information
- `tourism_venue`: Venue details and capacity
- `tourism_activity`: Activity scheduling and details
- `tourism_user_collection`: User favorites with target_type differentiation
- `tourism_activity_application`: Activity participation requests
- `tourism_activity_comment`: User comments with threading support

## Frontend Structure

### Key Directories
- `src/views/tourism/`: Tourism management pages
  - `scenicSpot/`: Scenic spot CRUD operations
  - `venue/`: Venue management interface
  - `activity/`: Activity creation and management
  - `activityApplication/`: Application approval workflow
- `src/api/`: API service layers for backend communication
- `src/components/`: Reusable Vue components (Pagination, FileUpload, etc.)
- `src/utils/`: Utility functions and request handlers

### Configuration
- **Proxy Setup**: Development server proxies API calls to `localhost:8080`
- **Asset Optimization**: Production builds include gzip compression
- **Code Splitting**: Separate chunks for Element UI, third-party libraries, and common components

## Development Notes

- **RuoYi Framework Integration**: Built on RuoYi's robust admin management foundation
  - User management, role-based access control, menu management
  - Dictionary management for dynamic configurations
  - Code generation tools for rapid CRUD development
- **Image Upload**: Utilizes RuoYi's existing file upload system for scenic spot/venue images
- **Frontend Styling**: Sass with Element UI theme customization
- **Development Experience**: Hot reload for both frontend (Vue CLI) and backend (Spring Boot DevTools)
- **Code Quality**: ESLint with pre-commit hooks via Husky

## AI Integration Roadmap

Planned integration of SpringAI + MCP for intelligent features:
- **智能景区推荐**: AI-powered scenic spot recommendations based on user preferences
- **个性化路线规划**: Intelligent travel route suggestions
- **文化体验推荐**: Activity and venue recommendations matching user interests
- **多语言支持**: AI-assisted content translation for international tourists

## Chongqing Tourism Context

This system specifically manages Chongqing's unique tourism landscape:
- **山城特色**: Mountain city geography and scenic spots
- **火锅文化**: Hot pot tourism and culinary experiences
- **红色旅游**: Revolutionary historical sites
- **长江三峡**: Three Gorges tourism resources
- **都市夜景**: City night tours and river cruises